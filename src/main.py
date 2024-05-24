import pygame
from easy_pygame import *

try:
    import pyi_splash
    pyi_splash.close()
except ImportError:
    pass
speed = [2, 2]
app = App()

class Platform(Rectangle):
    items = []
    HEIGHT = 50
    y = 0
    @classmethod
    def clunder(cls, obj):
        ret = None
        for plat in cls.items:
            if plat.rect.bottom >= obj.rect.bottom and plat.rect.left < obj.rect.right-30 and plat.rect.right > obj.rect.left+30:
                if ret is None:
                    ret = plat
                elif plat.rect.y < ret.rect.y:
                    ret = plat
        return ret
        
        
    def __init__(self, app, coord):
        super().__init__(app, (*coord, Platform.HEIGHT))
        Platform.items.append(self)

class Player(Sprite):
    def __init__(self):
        super().__init__(app, 'pac')
        self.rect.width = self.rect.height = 128
        self.vec.ay = 1000
        self.rect.center = (app.width/2, 600)
        
        d = 500
        self.add_anim('left', (0, 1, 2, 3), d)
        self.add_anim('idle', (4, ), d)
        self.add_anim('right', (5, 6, 7, 8), d)

        self.play_anim('idle')
        self.jump_state = 0
    def jump(self):
        if self.jump_state < 3 and self.vec.vy >= 0:
            self.vec.vy = -500
            self.jump_state += 1
        
@app.setup
def setup(app):
    global pac, joyb, joyi
    pac = Player()
    
    
    pad = 20
    h, w = 100, app.width - pad*4
    joyb = Rectangle(
        app,
        (pad, app.height*3/4, w, h),
        None,
        Color.RED,
        5
    )
    joyb.vec.offset = False
    joyi = Ellipse(
        app,
        (*joyb.rect.center, h, h),
        Color.RED,
    )
    joyi.vec.offset = False
    w, h = app.width, app.height
    p = Platform.HEIGHT
    
    coords = [
        (0, h-p-500, w),
        (w/2, h-p-650, w/3),
        (w/10, h-p-800, w/4),
        (w-w/3, h-p-900, w/3),
        *[
            (0, h-p-1000-x*200,w/3) if x%2==0 else (w-w/3, h-p-1000-x*200,w/3)
            for x in range(10)
        ]
    ]
    pac.rect.bottom = coords[0][1] - h * 2
    for coord in coords:
        Platform(app, coord)
    return True

@app.on_mousedown
def mousedown(app, pos):
    if joyb.rect.collidepoint(pos) or joyi.rect.collidepoint(pos):
        joyi.rect.center = pos
@app.on_mousemove
def mousemove(app, pos):
    joyi.rect.move_ip(pos)
    joyi.rect.clamp_ip(joyb.rect)
    cb = joyb.rect.center[0]
    ci = joyi.rect.center[0]
    cd = ci - cb
    cd/=10
    cd*=abs(cd)
    pac.vec.vx = cd
    if cd-20 > 0:
        pac.play_anim('right')
    elif cd+20 < 0:
        pac.play_anim('left')
    else:
        pac.play_anim('idle')
@app.on_mouseup
def mouseup(self, pos):
    if pac.rect.collidepoint(pos):
        pac.jump()
n = 0
@app.loop
def loop(app):
    global n; n += 1
    cl = Platform.clunder(pac)
    if cl is not None:
        if pac.vec.vy >= 0 and pac.rect.bottom >= cl.rect.top:
            pac.vec.vy *= -0.4
            pac.jump_state = 0
    if not app.is_mouse_down:
        joyi.vec.vx = 2*(joyb.rect.center[0]-joyi.rect.center[0])
    h = app.height
    if pac.rect.top < h/3:
        app.vel.y += 1
    elif pac.rect.bottom > h-h/3:
        app.vel.y -= 20
    else:
        app.vel.y*=0.5
    
    keys=pygame.key.get_pressed()
    if keys[K_LEFT]:
        joyi.rect.left -= 30
    if keys[K_RIGHT]:
        joyi.rect.left += 30
    if keys[K_UP]:
        pac.jump()
    cb = joyb.rect.center[0]
    ci = joyi.rect.center[0]
    cd = ci - cb
    cd/=10
    cd*=abs(cd)
    pac.vec.vx = cd
    if cd-20 > 0:
        pac.play_anim('right')
    elif cd+20 < 0:
        pac.play_anim('left')
    else:
        pac.play_anim('idle')

    pac.rect.clamp_ip(app.surface.get_rect())
    joyi.rect.clamp_ip(joyb.rect)
    joyi.rect.bottom += pac.vec.vy/30
    [plat() for plat in Platform.items]
    pac()
    joyb()
    joyi()
    return True
app.run()
