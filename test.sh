#!/bin/sh
##
#
userinfof() {
	title="Configurando usuarios - $titlep"
userinfo=$(yad --image=list-add-user --title="$title" --text="Configuracion de usuario" --center --button=Atras:1 --button=Siguiente:0 --text-align=center --height=200 --width=650 --form --field="Digite el nuevo usuario:" --field="Introduzca una contraseña:":H --field="Confirme la contraseña:":H)

if [ "$?" = "1" ]
then exit
fi

userinfo=(${userinfo//|/ })

if [[ "${userinfo[0]}" != *[!\ ]* ]] || [[ "${userinfo[1]}" != *[!\ ]* ]] || [[ "${userinfo[2]}" != *[!\ ]* ]]
then
yad --image=error --text="Debe completar todos los campos, vuelva a intentarlo." --title="$title" --center --button=Reintentar --height=100 --width=550
userinfof
fi

if [ "${userinfo[1]}" != "${userinfo[2]}" ]
then
yad --image=error --text="Las contraseñas no coinciden, vuelva a intentarlo." --title="$title" --center --button=Reintentar --height=100 --width=550
userinfof
fi
username=${userinfo[0]}
userpasswd=${userinfo[1]}
userpasswd2=${userinfo[2]}

useradd -m -g users -G adm,lp,wheel,power,audio,video,input,games,mail,scanner,storage,disk -s /bin/bash $username
touch .passwd
echo -e "$userpasswd\n$userpasswd2" > .passwd
passwd $username < .passwd >/dev/null

}