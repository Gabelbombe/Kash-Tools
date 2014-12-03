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
        LINUX_DISTRIBUTION=suse
      elif [ -e /etc/redhat-release ]; then
        LINUX_DISTRIBUTION=Redhat
      else
        LINUX_DISTRIBUTION=Unknown
      fi
    fi
  fi
  
  if [ -z "$LARCH" ]; then
  	LARCH="Unknown platform `uname`"
    exit 1
  fi

  return 'foo'
}

arch=$(get_architecture)

echo $arch

exit 0