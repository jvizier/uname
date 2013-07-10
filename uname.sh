#!/bin/sh

##BETA
#

#  /_/_/_/_/_/_/_/_/_/
# /_/   uname.sh  /_/
#/_/_/_/_/_/_/_/_/_/

#  /_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
# /_/ Vizier Jean-Marc 2012-01-02 /_/
#/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

#Support OS :
#Linux, Unix

#Support Distribution :
#RedHat/CentOS, Debian, FreeBSD, Solaris
#Ubuntu, Fedora

OS=`uname -s`

usage () {
        echo "Usage: uname.sh { -A | -k | -r | -o | -d | -v | -V | -a | --help}"
        return 0
}

#--| SCRIPT VERSION |-------------------------

script () {
VERSION="0.7 Beta"

printf "${VERSION}\n"
}

#--| KERNEL |---------------------------------

kernel () {
        if [ "${OS}" = "Linux" ] ; then
                                KERN=`uname -r | cut -b 1-10 | cut -d "-" -f 1,2`
        elif [ "${OS}" = "SunOS" ] ; then
                                KERN=`uname -v`
        fi
        printf "${KERN}\n"
}

#--| OS |-------------------------------------

os () {
        if [ "${OS}" = "Linux" ] ; then
                                OS=`uname -s`
    elif [ "${OS}" = "SunOS" ] ; then
                                OS=`uname -s`
        elif [ "${OS}" = "FreeBSD" ] ; then
                                OS=`uname -s`
    fi
    printf "${OS}\n"
}

#--| RELEASE |--------------------------------

release () {
        if [ "${OS}" = "Linux" ] ; then
                if [ -f /etc/fedora-release ]; then
                                RELEASE=`grep -o '[0-9]' /etc/redhat-release | sed '$!N;s/\n//'`
                elif [ -f /etc/redhat-release ]; then
                                RELEASE=`grep -o '[0-9]' /etc/redhat-release | sed '$!N;s/\n/u/'`
                elif [ -f /etc/lsb-release ] ; then
                                RELEASE=`cat /etc/lsb-release | grep RELEASE | cut -d = -f 2`
                elif [ -f /etc/debian_version ] ; then
                                RELEASE=`cat /etc/debian_version | cut -d "." -f 1-2`
                fi
        elif [ "${OS}" = "SunOS" ] ; then
                RELEASE=`uname -r`
        elif [ "${OS}" = "FreeBSD" ] ; then
                RELEASE=`uname -r | cut -d "-" -f 1`
        fi
        printf "${RELEASE}\n"
}

#--| ARCHI |---------------------------------

architecture () {
        if [ "${OS}" = "Linux" ] ; then
                ARCH=`uname -m`
        elif [ "${OS}" = "SunOS" ] ; then
                ARCH=`uname -m`
        elif [ "${OS}" = "FreeBSD" ] ; then
                ARCH=`uname -m`
        fi
        printf "${ARCH}\n"
}

#--| DISTRIB |-------------------------------

distribution () {
if [ "${OS}" = "Linux" ] ; then
        if [ -f /etc/redhat-release ] ; then
        DISTRIB_R=`grep -o "Red Hat" /etc/redhat-release | sed 's/ //'`
        DISTRIB_F=`grep -o "Fedora" /etc/redhat-release | sed 's/ //'`
        DISTRIB_C=`grep -o "CentOS" /etc/redhat-release | sed 's/ //'`
                if [ "${DISTRIB_R}" = "RedHat" ] ; then
                DISTRIB="RedHat"
                elif [ "${DISTRIB_F}" = "Fedora" ] ; then
                DISTRIB="Fedora"
                elif [ "${DISTRIB_C}" = "CentOS" ] ; then
                DISTRIB="CentOS"
                fi
        elif [ -f /etc/lsb-release ] ; then
        DISTRIB=`cat /etc/lsb-release | grep -w DISTRIB_ID | cut -d = -f 2`
        elif [ -f /etc/debian_version ] ; then
        DISTRIB="Debian"
        fi
elif [ "${OS}" = "SunOS" ] ; then
        DISTRIB="Solaris"
fi
printf "${DISTRIB}\n"
}

#--| VERSION |--------------------------------

version () {
        if [ "${OS}" = "Linux" ] ; then
                if [ -f /etc/redhat-release ] ; then
                VERSION_S=`grep -o '[A-Z][A-Z]' /etc/redhat-release`
                VERSION_W=`grep -o 'Desktop' /etc/redhat-release`
                VERSION_S2=`grep -o "\(Enterprise\|Server\)" /etc/redhat-release | sed 's/$/ /;$!N;s/\n//'`
                VERSION_A=`grep -o "\(Advanced\|Server\)" /etc/redhat-release | sed 's/$/ /;$!N;s/\n//'`
                        if [ "${VERSION_S}" = "AS" ] ; then
                                VERSION=${VERSION_S}
                        elif [ "${VERSION_S2}" = "Enterprise Server" ] ; then
                                VERSION="ES"
                        elif [ "${VERSION_A}" = "Advanced Server" ] ; then
                                VERSION="AS"
                        elif [ "${VERSION_S}" = "ES" ] ; then
                                VERSION=${VERSION_S}
                        elif [ "${VERSION_S}" = "WS" ] ; then
                                VERSION=${VERSION_S}
                        elif [ "${VERSION_W}" = "Desktop" ] ; then
                                VERSION=${VERSION_W}
                        fi
                elif [ -f /etc/lsb-release ] ; then
                VERSION=`cat /etc/lsb-release | grep -w DISTRIB_CODENAME | cut -d = -f 2`
                fi
                printf "${VERSION}\n"
        fi
}

#--| Full |----------------------------------

Full (){
#LINUX
if [ "${OS}" = "Linux" ] ; then
        #REDHAT
        if [ -f /etc/redhat-release ] ; then
        printf "`os` `architecture` `distribution` `version` `release` `kernel`\n"
        #FEDORA
        elif [ -f /etc/fedora-release ] ; then
        printf "`os` `architecture` `distribution` `release` `kernel`\n"
        #UBUNTU
        elif [ -f /etc/lsb-release ] ; then
        printf "`os` `architecture` `distribution` `release` `version` `kernel`\n"
        #DEBIAN
        elif [ -f /etc/debian_version ] ; then
        printf "`os` `architecture` `distribution` `release` `kernel`\n"
        fi
#SUNOS
elif [ `uname -s` = "SunOS" ] ; then
        printf "`os` `release` `architecture`\n"
#FREEBSD
elif [ `uname -s` = "FreeBSD" ] ; then
        printf "`os` `release` `architecture`\n"
fi
}


#--| HELP |----------------------------------

help () {
        echo ""
        echo " ----------------------------------- "
        echo "|              uname.sh             |"
        echo " ----------------------------------- "
        echo "             -=OPTIONS=-             "
        echo " ----------------------------------- "
        echo "| -A >----------------Full ENV PATH |"
        echo "| -k >---------------Display Kernel |"
        echo "| -r >--------------Display Release |"
        echo "| -o >-------------------Display Os |"
        echo "| -a >---------Display Architecture |"
        echo "| -d >------Display Os Distribution |"
        echo "| -v >-Display Distribution Version |"
        echo "| -V >-------Display Script Version |"
        echo " ----------------------------------- "
        echo ""
}

#--| MENU |----------------------------------

case $1 in
        "-A")
                Full
                ;;
        "-k")
                kernel
                ;;
        "-r")
                release
                ;;
        "-o")
                os
                ;;
        "-a")
                architecture
                ;;
        "-d")
                distribution
                ;;
        "-v")
                version
                ;;
        "-V")
                script
                ;;
        "--help")
                help
                ;;
        *)
                usage
                ;;
esac
