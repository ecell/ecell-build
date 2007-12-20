Summary: E-Cell is a generic software package for cellular modeling and simulation.
Name: ecell3
Version: 3.1.106rc2
Release: 1
URL: http://www.e-cell.org/
Source: ecell-%{version}.tar.gz
License: GPL
Group: Applications
Packager: Takeshi Sakurada
BuildRoot: %{_tmppath}/%{name}-root

Requires: numpy >= 1.0.3
Requires: gsl >= 1.8
Requires: boost >= 1.33.0
Requires: libstdc++
Requires: python >= 2.3
Requires: glibc
BuildRequires: make
BuildRequires: python-numeric
BuildRequires: python-devel
BuildRequires: glibc-devel
BuildRequires: libstdc++-devel
BuildRequires: gcc-c++
BuildRequires: gsl-devel >= 1.8
BuildRequires: boost-devel >= 1.33.0
BuildRequires: libstdc++-devel
BuildRequires: doxygen
BuildRequires: docbook-utils
BuildRequires: docbook-utils-pdf

%description
E-Cell System is an object-oriented software suite for modeling,
simulation, and analysis of large scale complex systems, particularly focused
on biological details of cellular behavior.

%package devel
Summary: Developer package for E-Cell System.
Group: Development/Libraries
Requires: ecell3 = %{version}
Requires: python-numeric
Requires: gsl-devel
Requires: boost-devel >= 1.33.0
Requires: libstdc++-devel

%description devel
E-Cell System is an object-oriented software suite for modeling,
simulation, and analysis of large scale complex systems, particularly focused
on biological details of cellular behavior.

%package session-monitor
Summary: E-Cell Session Monitor
Group: Development/Libraries
Requires: ecell3 = %{version}
Requires: python >= 2.3
Requires: pygtk2 >= 2.6
Requires: gnome-python2-canvas >= 2.6

%description session-monitor
E-Cell System is an object-oriented software suite for modeling,
simulation, and analysis of large scale complex systems, particularly focused
on biological details of cellular behavior.

%package model-editor
Summary: E-Cell Model Editor
Group: Development/Libraries
Requires: ecell3 = %{version}
Requires: python >= 2.3
Requires: pygtk2 >= 2.6
Requires: gnome-python2-canvas >= 2.6

%description model-editor
E-Cell System is an object-oriented software suite for modeling,
simulation, and analysis of large scale complex systems, particularly focused
on biological details of cellular behavior.

%package tool-launcher
Summary: E-Cell Tool Launcher
Group: Development/Libraries
Requires: ecell3 = %{version}
Requires: python >= 2.3
Requires: pygtk2 >= 2.6
Requires: gnome-python2-canvas >= 2.6

%description tool-launcher
E-Cell System is an object-oriented software suite for modeling,
simulation, and analysis of large scale complex systems, particularly focused
on biological details of cellular behavior.


%prep
%setup -n ecell-%{version}

%ifarch i686
CXXFLAGS="-O2 -mfpmath=sse -msse2 $RPM_OPT_FLAGS" ./configure --prefix=%{_prefix}
%else
CXXFLAGS="$RPM_OPT_FLAGS" ./configure --prefix=%{_prefix}
%endif

%build
%configure
make

%install
make \
    %{?buildroot:DESTDIR=%{buildroot}} \
    prefix=%{_prefix} \
    exec_prefix=%{_exec_prefix} \
    bindir=%{_bindir} \
    sbindir=%{_sbindir} \
    sysconfdir=%{_sysconfdir} \
    datadir=%{_datadir} \
    includedir=%{_includedir} \
    libdir=%{_libdir} \
    libexecdir=%{_libexecdir} \
    localstatedir=%{_localstatedir} \
    sharedstatedir=%{_sharedstatedir} \
    mandir=%{_mandir} \
    infodir=%{_infodir} \
    install
mv ${RPM_BUILD_ROOT}/usr/share/doc/ecell/users-manual .
mv ${RPM_BUILD_ROOT}/usr/share/doc/ecell/api .
mv ${RPM_BUILD_ROOT}/usr/share/doc/ecell/model-editor .
mv ${RPM_BUILD_ROOT}/usr/share/doc/ecell ${RPM_BUILD_ROOT}/usr/share/doc/ecell3

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%doc AUTHORS COPYING COPYING.LGPLv2 COPYING.LGPLv3 ChangeLog INSTALL NEWS README users-manual
/usr/bin/ecell3-em2eml
/usr/bin/ecell3-eml2em
/usr/bin/ecell3-eml2sbml
/usr/bin/ecell3-python
/usr/bin/ecell3-sbml2eml
/usr/bin/ecell3-session
/usr/bin/ecell3-session-manager
/usr/lib/libecs.so.*
/usr/lib/libemc.so.*
/usr/lib/ecell-3.1/dms
/usr/share/doc/ecell3/samples
/usr/lib/python2.5

%files devel
%defattr(-,root,root)
%doc AUTHORS COPYING README api
/usr/bin/dmcompile
/usr/bin/ecell3-dmc
/usr/include/dmtool
/usr/include/ecell-3.1
/usr/share/ecell-3.1/dms
/usr/lib/libecs.so
/usr/lib/libecs.la
/usr/lib/libemc.so
/usr/lib/libemc.la

%files session-monitor
%defattr(-,root,root)
%doc AUTHORS COPYING README
/usr/bin/gecell
/usr/bin/ecell3-session-gui
/usr/bin/ecell3-session-monitor
/usr/lib/ecell-3.1/session-monitor

%files model-editor
%defattr(-,root,root)
%doc AUTHORS COPYING README model-editor
/usr/bin/ecell3-model-editor
/usr/lib/ecell-3.1/model-editor

%files tool-launcher
%defattr(-,root,root)
%doc AUTHORS COPYING README
/usr/bin/ecell3-toollauncher
/usr/lib/ecell-3.1/toollauncher

%changelog
* Fri Dec 21 2007 Moriyoshi Koizumi <mozo@sfc.keio.ac.jp>
- Reorganize package system for E-Cell 3.1.106 release.

* Mon May 31 2004 Takeshi Sakurada <sakurada@e-cell.org>
- The list of requires was modified for the recent Fedora Core environment. 

* Sun Oct 13 2002 Takeshi Sakurada <sakurada@e-cell.org>
- Initial build.

