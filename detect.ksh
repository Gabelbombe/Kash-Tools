#!/bin/ksh

get_architecture ()
{
  # Determine architecture and platform
  if [ `uname` = AIX ]; then
    LARCH=ibmpow
    PLATFORM_NAME=AIX

  elif [ `uname` = SunOS ]; then
    if [ `uname -p` = sparc ]; then
      LARCH=sunspa
      PLATFORM_NAME=Solaris
    else
      LARCH=sunx86
      PLATFORM_NAME=Solaris/x86
    fi

  elif [ `uname` = Linux ]; then
    LARCH=linux
    UNAME=`uname -m`
    if [ $UNAME = s390 ]; then
      PLATFORM_NAME=zLinux
    elif [ $UNAME = s390x ]; then
      PLATFORM_NAME=zLinux
    else
      PLATFORM_NAME=xLinux
    fi
  
    # Query linux distribution
    if [ ${LARCH} = "linux" ]; then
      if [ -e /etc/SuSE-release ]; then
        LINUX_DISTRIBUTION=SuSE
      elif [ -e /etc/redhat-release ]; then
        LINUX_DISTRIBUTION=Redhat
      elif [ -e /etc/fedora-release ]; then
        LINUX_DISTRIBUTION=Fedora
      elif [ -e /etc/slackware-release ]; then
        LINUX_DISTRIBUTION=Slackware
      elif [ -e /etc/debian_release ]; then
        LINUX_DISTRIBUTION=Debian
      elif [ -e /etc/mandrake-release ]; then
        LINUX_DISTRIBUTION=Mandrake
      elif [ -e /etc/yellowdog-release ]; then
        LINUX_DISTRIBUTION=YellowDog
      elif [ -e /etc/release ]; then
        LINUX_DISTRIBUTION=Solaris # flagged earlier
      elif [ -e /etc/sun-release ]; then
        LINUX_DISTRIBUTION=SunJDS
      elif [ -e /etc/gentoo-release ]; then
        LINUX_DISTRIBUTION=Gentoo
      elif [ -e /etc/UnitedLinux-release ]; then
        LINUX_DISTRIBUTION=UnitedLinux
      elif [ -e /etc/lsb-release ]; then
        LINUX_DISTRIBUTION=Ubuntu
      else
        LINUX_DISTRIBUTION=Unknown
      fi
    fi
  fi
  
  if [ -z "$LARCH" ]; then
    LARCH="Unknown platform `uname`"
    exit 1
  fi

  return 0
}

arch=$(get_architecture)

exit 0