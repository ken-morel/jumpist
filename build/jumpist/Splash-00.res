tcl86t.dll      tk86t.dll       tk              __splash             �  '  �  P   Xapi-ms-win-crt-time-l1-1-0.dll api-ms-win-core-memory-l1-1-0.dll api-ms-win-crt-math-l1-1-0.dll tk\ttk\ttk.tcl api-ms-win-crt-stdio-l1-1-0.dll api-ms-win-core-file-l1-2-0.dll tk86t.dll tk\ttk\fonts.tcl api-ms-win-crt-heap-l1-1-0.dll api-ms-win-core-handle-l1-1-0.dll api-ms-win-core-processenvironment-l1-1-0.dll api-ms-win-core-util-l1-1-0.dll api-ms-win-core-synch-l1-1-0.dll api-ms-win-crt-environment-l1-1-0.dll api-ms-win-core-localization-l1-2-0.dll api-ms-win-core-libraryloader-l1-1-0.dll tk\text.tcl api-ms-win-core-profile-l1-1-0.dll ucrtbase.dll tcl86t.dll api-ms-win-core-processthreads-l1-1-1.dll api-ms-win-core-debug-l1-1-0.dll VCRUNTIME140.dll api-ms-win-crt-utility-l1-1-0.dll api-ms-win-core-string-l1-1-0.dll api-ms-win-core-namedpipe-l1-1-0.dll api-ms-win-core-file-l2-1-0.dll api-ms-win-core-file-l1-1-0.dll tk\ttk\utils.tcl api-ms-win-crt-string-l1-1-0.dll tk\tk.tcl api-ms-win-core-synch-l1-2-0.dll api-ms-win-crt-runtime-l1-1-0.dll api-ms-win-core-timezone-l1-1-0.dll api-ms-win-core-processthreads-l1-1-0.dll api-ms-win-core-console-l1-1-0.dll api-ms-win-core-heap-l1-1-0.dll api-ms-win-core-rtlsupport-l1-1-0.dll api-ms-win-core-datetime-l1-1-0.dll api-ms-win-crt-convert-l1-1-0.dll api-ms-win-core-interlocked-l1-1-0.dll api-ms-win-core-errorhandling-l1-1-0.dll tk\license.terms api-ms-win-core-sysinfo-l1-1-0.dll tk\ttk\cursors.tcl proc _ipc_server {channel clientaddr clientport} {
set client_name [format <%s:%d> $clientaddr $clientport]
chan configure $channel \
-buffering none \
-encoding utf-8 \
-eofchar \x04 \
-translation cr
chan event $channel readable [list _ipc_caller $channel $client_name]
}
proc _ipc_caller {channel client_name} {
chan gets $channel cmd
if {[chan eof $channel]} {
chan close $channel
exit
} elseif {![chan blocked $channel]} {
if {[string match "update_text*" $cmd]} {
global status_text
set first [expr {[string first "(" $cmd] + 1}]
set last [expr {[string last ")" $cmd] - 1}]
set status_text [string range $cmd $first $last]
}
}
}
set server_socket [socket -server _ipc_server -myaddr localhost 0]
set server_port [fconfigure $server_socket -sockname]
set env(_PYIBoot_SPLASH) [lindex $server_port 2]
image create photo splash_image
splash_image put $_image_data
unset _image_data
proc canvas_text_update {canvas tag _var - -} {
upvar $_var var
$canvas itemconfigure $tag -text $var
}
package require Tk
set image_width [image width splash_image]
set image_height [image height splash_image]
set display_width [winfo screenwidth .]
set display_height [winfo screenheight .]
set x_position [expr {int(0.5*($display_width - $image_width))}]
set y_position [expr {int(0.5*($display_height - $image_height))}]
frame .root
canvas .root.canvas \
-width $image_width \
-height $image_height \
-borderwidth 0 \
-highlightthickness 0
.root.canvas create image \
[expr {$image_width / 2}] \
[expr {$image_height / 2}] \
-image splash_image
wm attributes . -transparentcolor magenta
.root.canvas configure -background magenta
pack .root
grid .root.canvas -column 0 -row 0 -columnspan 1 -rowspan 2
wm overrideredirect . 1
wm geometry . +${x_position}+${y_position}
wm attributes . -topmost 1
raise .�PNG

   IHDR   �   �   �>a�    cHRM  z&  ��  �   ��  u0  �`  :�  p��Q<   	pHYs  �  ��+   bKGD������	X��   tIME�.�V�   caNv      �   �    e�S�   %tEXtdate:create 2024-05-18T04:34:53+00:00���P   %tEXtdate:modify 2024-05-18T04:45:45+00:00�dg�   (tEXtdate:timestamp 2024-05-18T04:46:20+00:00��	  �IDATx^�ٓ$Wyųz��� l��BH�I`c"x%��9x�ɯ�x �&�b؀�$!����Lo��;�~9�[uWuVVV��BWY[�T�9���{�֨��Zc��>���nV��Uup]�U��{_��������noi����i�7�Q�a����qWU�ݣq��}����]㏪j�Ot|W���ޭ�߮F�5�e�A��2@5��@����kz��L���^�s�t�u �Q���9H����ol�D�i�5F��c>
�uH��N�f\K��k��i]o�aB�I�a�pO�k{� ?x]G�>����D^g��[@f�ۛ������8&A(c��#+�	���m(D@8�A����b�6H�x�=]k�'����|�cG�g < �|-�@6���a�
"po�6��}�Z$Y�ա�	�ߡ!E�xw
($������`�%@H��GKΉ���m��K�-�zMx{�g#�}dh��t+�B�I@n 	 $P΀*8�& ����0���>�� ���Ƌ�A��sg���"L#�E1>�pL�d�G�y@��Ta��,�B {<���<y0o�#G�Uk<�����I���E�{���+�4��x�	P ����Ƈ5>��;<�y�c"�D y-�8����xy��:2D˽B 	��{��ޕ��R=8G�U�s�������$�R���w�_�����Bǟ�#$�����-��CdPx O�"|���P��u|P�����7,�B�;I�[M���?��?Kd ����W�LH��`3H����P� _�Pnn*$Pu���! �;�y���/[�붽��iҬ0�a&j@�@� 	��$0����b�&嘣͕ ��U������~����6үL�]�!���n���΁� �w� ��zH㉪,��Ғ&���y$�s#@*�h�(�h �%��$���u�F��"@BBJ 	 A�ݫ��@"Ȕsx��e���;�o�uW��[�
��וlD��:jP9�@�,]*A�h�=�pUڑ������ 2�+!��������ǫj�)�y$oXcƱ��[ �L����WU��GG�
X��H~���Ə%@h$�8v�F� ��Ż���^/�o}W����9�ɿ�aA	��dU�J	>��I�W���񥕠�̽����;�|E�<K~���v2Oi���� @H�!���Q�K�q��Ξ��������H�X�QlF�J`H�LJ@1���*���x�u����J�(��|���%M����,���E���M7�Nv+9�6�v8�+�c��������<��~4wJ�ם�C�K�|�cq�5 ���M�]� ;�0��I�`$�S�0�4w�cVk��n���w���bW���>�LM ��ڳy�֮K=b�s�g66�rv�H�䜋0�+���XP�)���`v��H�2}dI:ԇr����L�ұ����yi�C9��-(�pJ����`��������>����]�q�� �	���^<'�X�������z�yh3�L�h�����3:>�E�.:�2�0��+�'�s�������Sr�J�w�͚>��:�,��Av���h�S�7�x�
��IH�������?ˍ�k���؅�,�fJ�o~=��'䄬��5x:�2�XC���L�Ps�6�{M�YI~�����,1����������?�hC���X |� J4P �|2Q˽����~y�קS�e������m&h�t��	��g���k
�2�ձ��{"#�	����ϱ��%�4vh�0h@X�V��'�re�u�����言�skxQ��a�������+|{O��H}p�]qTI� �����O�f���a�B��;W��p�Sy����s� b*9���,����{��{��'D�8*0]qՍ�/���#�����l�����&��c��xүx�z�猷s�_�2�uy:���i���о�/�z��O�!s�}� �tF�Xs���G�@UɆ���ۈ�d����L*�/����b�)�9��u���y ��л�(Y��K�fXn�ZO�̞��x3O�(�{A�y�~2ݾ˝�����gY6u�yI]�W�#U�y3Gk:�����������&��Rod���^��]A��w�Q�껻�s���Ib���7���ǌς���,��D%a�qO*��0S��`����;��XND��ݣ����� ��Q��u��O2�A���@ЭP��l_{q:~'p��-�~jKՔ����G�������MoT8�{gO���:Ѽ���R��vE��`��"�����0pR`�=�/&���	��Y�����9a�;�||��$�y�|pR���.��מ�u�fvd��d&��iW�l'	>f5	�N ɠ�c�	�w���E�%�n~��ŋ��7�R\uY�gt$��9�(��l-��)!�	�>�K���TGP���E�b������fZt@B�J�=��K�)i���H��S�I�M�-�09H�$�C
�nk_���P�)��s���\���!��?̓[�JӼ�:��Ķ+c:%Gfi��f��B2����$�3(R8a�J�$�Rs�{�_� UU���Vk��knȿd��ORCV{�L ��R(��;xV����^��*(��Y$�C�|��tT�U!݉j�L��̋�i��?�v�Xզ��	���q���<��Be ?���Ah91�r��s>w� ͋�~�v9�cVq�gX �����97Ⱦ�k��g3�C�ql��� ���ϗ|���2�+L�#���18�?��r�-}�
��
��:�׀!��޿d_v�F��X:ӇF��Qv ����E�;&�@�-�e�R�2i�����?� @��{���Ŗ� ��J�-�)O�~A�,�E�j�P���[$��%Hn��������<���6+��]��S,je;:/]��S�k�H�@��`�[U��?���"z�"�U��-�	|�]`�1�yK{�$KظMS���>Dnl�#�Ԟ2�"���͚�B�aY��X��]HY�$�6��;�U�C/aU�n{�� UK!8B�ר>x-�濊 _��a�`� ��,�^Y`���(<>{��� ͑��I��v���{�ɔ�;ۨ�Yx^���z�K���*�`!@�����Ych�f�D�^����\�I�������n|9�:=�_����#rN��x�B�#�0���"�����wHؐ�����^���<~�F��� /H�M�;�r|&6J��� 9�o{8���:��6 zx:����<S����mT�|[x1'��Py��	P�;��]`�G։�x1������5�����<7tL"nC(<~���7�)����0�Ϫ ���a),ˬ���6	\�:@jp�����H����x8�׽��7�(������@�ؔ�'6r.�ޫۖq<�#��c�� y���|��J�EmT������|G��R ���1KIT:��x��)XH;`ڋI�B޹/Og�G=�v�@��h%o]�|����#���"�7�����*�@ :���X�O�c�eIl���vy��A~��}կ~!�;~(�\L�F�!� �4#�m@�8��s�����Hy��`��'{�/|lT��y� ���n�)����
�����,���:Y|�6��Ȼ�e��H{�s�F�W�@�'y��D���`sg�W� �N� X�{�M�ׇwC�l�x;ထ�|蠷-@q��=^5|�ģ}���4X�]�<<�2�	9� pB���#�g�>i���bߟ@6��db���M ��ȷ�#��-�x@E�}��?��n-_h�D�c��i�un" ^���*��ڸ]�Ľ���(UE����rm�S�{/U���U}����h�j��+�l%UIKX����]�2�4��0�� $���d#����1o� TceZ�e2��N��m�����E���*��d@�3	r(�n7!�#�����!E�H���p_a�*Q�tb�c��AF�F%�}���5 �����%a=��s��-	+�B{4 <�@��^}�� �nC�U�1^������`eYx���&d��F! Ĉpd |�J!���h�@ DHy�����T�ra��L �zaH�4l`�Vd=�{�� ܬѝ�*��@%�FI G����a���%2d=H!0!B�'@ � ��_Z._RC%P�v�R�v���(�����c�Zo�}c�ț_KG��T�$��H�P��H�#���� Uxo����"��B���?���4��Cz��P���f={<�t�Vy]�;�	H���l����c�P�E�3O�'��Ǌ-�� ttR���� c�Q(�&@�5Q��bKn�D������i�@��3GZ�d��ęb�m�\���YI��0�
 �=6�Cԏ$���R�g�tg�~@V d�r�rAOz�
��J.��极���.]�� )ě 0�u�I��x�5=�ǋ-�e��u��� ɱ�d��0E5#*�[RC���-����3g���<��j@Lq���B%<ʓbKbƓ�ϕN8��.�,J��D���r(��T�g��5�����?�y� �W�����QH�tvęE�t�Rz���� ����l�rz��B���8�7�� ���N ��j�� �
�b7�~���W�o�5���;� 2����Ƽ����M�0Pl�f����.���Q���;� 6��h�O|Ho"5@R�%���S�)�q\�7 �;�O͟�M ��&��=�_�"2����`�=9.��N�ߦ�o|B���	�S�#H���h��S�Tlіc��~I��#"�ú-����$�K�5*:����ѕ��X	òfQ�*6ʾ͏/� K�&��LP�d�#��M�>�#� ��L�\�K�����\���]� 6���[Mc���ŝ�r�E�0`�'����'�����.F b���
􏹴(��⌸O�F㎞�d�J����yv!�9�)�k���b�":��Q��Mp҇:g���J=�w�]��	�����&�?P�Wsɧ8O�w~F�O�����X�>��:�$!$�e�P�{����ҏ3�����?�p�J{��	�_ۦB�*�:AF98�?���$=,%+�~,�=���Ǆ�S"zH��`j�M��hQoJz��?�A�є%�͚N�S�	x������� �]�]w*��?)~"��ltB��%̉8�+��~Z�S:�x>}�-F�{# �'U�@�P 	H����t;3{>�8�[!w��֠C����Twf�U�?�	#zϒ#���>���-��儏j��r}�sC�p��lZ��E�^�RVr���bD6��s��^��l��Lf�s�G��� ��x����c� c�������{.m3	�}t�Y=Ύ#\��5jeρ�X�|�>���}�N�G����>m��)lg��2�:�(�M�����{)]���:�'W��o��=%|$�d���i�QrO��f��K��$ٗ#�V��,���4D��G%��C��:/�q��^u���X���Mn�)�V4^��;	�~�ԁ-�!I		ِ{y���	`J����x����c�����G ��U/�gw
6�DLBB���QMyR�%ܒ�fVOG:�n�1��������� ��ql��<���ޮD�`��d��W!4p�9H�I�"�[�i�9��t�\�ѥ͕ a��NuxC�;��K��� ؍�2�� ;�B�U7<�'�����m��e\������s����C�H��L�@j��|�J٭�D��L��X�Ǝ=��:rOm�J��k� ���������v� O痹 }�P@n���@�J�I"��aYC2��d{=��6��:��Y������Rz' v��} �O�	|�0�gڨح�����Vlr�l������}�.�[*�#��;�}ߧ�����|lA����m��T-x_;��� ,H) 
E�����!(��u$Y��oTjz���%�Ԏ��\cA���S���_]�[*QH����F���E���p��\U W ���EX[��A��;��W���u�:@���{�_�?͆A�&I�\)¡� B�w�!�  ��Eq"W�3L����~�@U�F|������>�."x�f��5&K7���� pܜ#@���kd�M��Ѫ YPd`�)�FF���7�#FX�8�r`�ͱ}��\��mo��
�j�耯a�'��ɛE��$$�`��%�x=N&��y������
V����(F������G�W��ǠU�������+�]����>G�t<�_Yh�&��D@�W�2) �J�p��@��Q�$�uR���f�ABF�����L[�5�;�sxY�=�Q��Z�dA-������M��̝E�+o� >�	�H`h+G{	��
�4���:�*`s;��#�C��� �M��ӭ���S�;m�!    IEND�B`�