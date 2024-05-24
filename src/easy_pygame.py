from pygame.locals import *
from pygame import *
import sys
import time
import pygame
import functools
from pathlib import Path

class Color:
    DEFAULT = (12, 34, 56)
    BLACK = (0, 0, 0)
    WHITE = (255, 255, 255)
    RED = (255, 0, 0)

                      
class Vec():
    offset = True
    def __init__(self, pos, vel=(0, 0), acc=(0, 0)):
        self.v = pos
        self.vx, self.vy = vel
        self.ax, self.ay = acc
        self.t = time.perf_counter()
    def update(self, v=None):
        if v:
            self.v = v
        if self.offset:
            v.move_ip(App.app.vel)
        ct = time.perf_counter()
        dt = ct - self.t
        
        self.v.left += self.vx*dt
        self.v.top += self.vy*dt
        
        self.vx += self.ax*dt
        self.vy += self.ay*dt
        self.t = ct
        
        
class Shape:
    vec=None
    def __init__(self, app):
        self.app = app
        self.surf = app.surface
    def update(self):
        if self.vec is not None:
            self.vec.update(self.rect)

class Image(Shape):
    def __init__(self, app, url, pos=None):
        super().__init__(app)
        
        self.raw = pygame.image.load(url)
        
        self.rect = self.raw.get_rect()
        self.vec = Vec(self.rect)
        #print(dir(self.rect))
        if pos is not None:
            self.rect.update(pos)
        #     print(dir(self.rect))

    def __call__(self, rect=None):
        if rect is not None:
            if rect != self.rect:
                self.rect.update(rect)
        self.surf.blit(
            self.raw,
            self.rect
        )


class Sprite(Shape):
    @staticmethod
    def Anim(frames, dur):
        begin = time.perf_counter()
        while True:
            #print(begin, time.perf_counter()-begin)
            v = yield frames[
                int((time.perf_counter()-begin)*1000//dur%len(frames))
            ]
            
    def add_anim(self, name, frames, dur):
        self.anims[name] = Sprite.Anim(frames, dur)
    def play_anim(self, name):
        self.anim = self.anims.get(name)
    def __init__(self, app, dir, pos=None):
        super().__init__(app)
        self.frames = []
        self.anims = {}
        self.anim = None

        files = sorted(
            Path(dir).glob('*.*'),
            key=lambda p: int(p.stem)
        )
        for file in files:
            self.frames.append(i:=Image(app, file))
                
        if pos is not None:
            self.rect = Rect(pos)
        else:
            self.rect = i.rect
        self.vec = Vec(self.rect)
    def __call__(self):
        self.update()
        if self.anim is not None:
            self.frames[next(self.anim)](self.rect)
######
class Rectangle(Shape):
    def __init__(self, app, rect, fill=Color.DEFAULT, stroke=Color.DEFAULT, strokesize=0):
        super().__init__(app)
        self.rect = Rect(rect)
        self.fill = fill
        self.stroke = stroke
        self.strokesize = strokesize
        self.vec = Vec(self.rect)
    def __call__(self):
        self.update()
        if self.fill is not None:
            pygame.draw.rect(self.surf, self.fill, self.rect)
        if self.strokesize > 0:
            pygame.draw.rect(self.surf, self.stroke, self.rect, self.strokesize)
            
    
    
class Ellipse(Shape):
    def __init__(self, app, rect, fill=Color.DEFAULT, stroke=Color.DEFAULT, strokesize=0):
        super().__init__(app)
        self.rect = Rect(rect)
        self.fill = fill
        self.stroke = stroke
        self.strokesize = strokesize
        self.vec = Vec(self.rect)
    def __call__(self):
        self.update()
        if self.fill is not None:
            pygame.draw.ellipse(self.surf, self.fill, self.rect)
        if self.strokesize > 0:
            pygame.draw.ellipse(self.surf, self.stroke, self.rect, self.strokesize)
            
            
            

class App:
    is_mouse_down = False
    x = y = 0
    _setup = _loop = _exit = _mdown = _mup = _mmove = lambda *_: True
    def __init__(self, size=(500, 500), fps=20, clearcolor=Color.BLACK):
        pygame.init()
        App.app = self
        self.vel = Vector2()
        self.surface = pygame.display.set_mode(size)
        self.clock = pygame.time.Clock()
        self.width = self.surface.get_width()
        self.height = self.surface.get_height()
        self.events = []
        self.fps = fps
        self.clearcolor = clearcolor
    def setup(self, func=None):
        if func is not None:
            assert callable(func), 'only callables can be passed for setup'
            self._setup = func
        else:
            return self._setup(self)
        return self.setup
    def loop(self, func=None):
        if func is not None:
            assert callable(func), 'only callables can be passed for loop()'
            self._loop = func
        else:
            return self._loop(self)
        return self.loop
    def on_mousedown(self, func=None):
        if func is not None:
            assert callable(func), 'only callables can be passed for mousedown()'
            self._mdown = func
        
        return self._mdown
    def on_mousemove(self, func=None):
        if func is not None:
            assert callable(func), 'only callables can be passed for mousedown()'
            self._mmove = func
        
        return self._mmove
    def on_mouseup(self, func=None):
        if func is not None:
            assert callable(func), 'only callables can be passed for mouseup()'
            self._mup = func
        return self._mup
    def exit(self, func=None):
        if func is not None:
            assert callable(func), 'only callables can be passed for loop()'
            self._exit = func
        else:
            return self._exit(self)
        return self.loop
    def quit(self, code=0):
        '''closes the app'''
        pygame.quit()
        sys.exit(code)
    def run(self):
        c = self.setup()
        while c:
            self.events = pygame.event.get()
            for e in self.events:
                if e.type == QUIT:
                    if self.exit():
                        self.quit()
                elif e.type == MOUSEBUTTONDOWN:
                    self._mdown(self, e.pos)
                    self.is_mouse_down = True
                    pygame.mouse.get_rel()
                elif e.type == MOUSEBUTTONUP:
                    self._mup(self, e.pos)
                    self.is_mouse_down = False
            if self.is_mouse_down:
                x, y = pygame.mouse.get_rel()
                self._mmove(self, (x, y))
            self.surface.fill(self.clearcolor)
            if not self.loop():
                  self.quit(0)
            pygame.display.flip()
            self.clock.tick(self.fps)