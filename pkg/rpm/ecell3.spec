%{!?python_sitelib: %define python_sitelib %(python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")}

Summary: E-Cell is a generic software package for cellular modeling and simulation.
Name: ecell3
Version: 3.2.1
Release: 1%{?dist}
URL: http://www.e-cell.org/
Source: ecell-%{version}.tar.bz2
Patch0: ecell-3.2.1-ply-2.3-compat.patch
License: GPL
Group: Applications
Packager: Takeshi Sakurada
BuildRoot: %{_tmppath}/%{name}-root

Requires: numpy >= 1.0.3
Requires: gsl >= 1.5
Requires: boost >= 1.32.0
Requires: libstdc++
Requires: python >= 2.3
Requires: python-ply >= 2.3
Requires: glibc
BuildRequires: make
BuildRequires: python-devel
BuildRequires: pygtk2 >= 2.4
BuildRequires: python-ply >= 2.3
BuildRequires: glibc-devel
BuildRequires: libstdc++-devel
BuildRequires: gcc-c++
BuildRequires: gsl-devel >= 1.5
BuildRequires: boost-devel >= 1.32.0
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
Requires: numpy >= 1.0.3
Requires: gsl-devel
Requires: boost-devel >= 1.32.0
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
Requires: pygtk2 >= 2.4
Requires: pygtk2-libglade >= 2.4

%description session-monitor
E-Cell System is an object-oriented software suite for modeling,
simulation, and analysis of large scale complex systems, particularly focused
on biological details of cellular behavior.

%package model-editor
Summary: E-Cell Model Editor
Group: Development/Libraries
Requires: ecell3 = %{version}
Requires: ecell3-session-monitor = %{version}
Requires: python >= 2.3
Requires: pygtk2 >= 2.4
Requires: pygtk2-libglade >= 2.4
Requires: gnome-python2-canvas >= 2.4

%description model-editor
E-Cell System is an object-oriented software suite for modeling,
simulation, and analysis of large scale complex systems, particularly focused
on biological details of cellular behavior.

%prep
%setup -n ecell-%{version}
%patch0 -p1

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
    docdir=%{_datadir}/doc/ecell3 \
    install
rm -rf ${RPM_BUILD_ROOT}/usr/lib/python*
mv ${RPM_BUILD_ROOT}%{_datadir}/doc/ecell3/users-manual .
mv ${RPM_BUILD_ROOT}%{_datadir}/doc/ecell3/api .
mv ${RPM_BUILD_ROOT}%{_datadir}/doc/ecell3/model-editor .
mv ${RPM_BUILD_ROOT}%{_datadir}/doc/ecell3/samples .
rm -rf ${RPM_BUILD_ROOT}%{_datadir}/doc/ecell3

%clean
rm -rf ${RPM_BUILD_ROOT}

%files
%defattr(-,root,root)
%doc AUTHORS COPYING COPYING.LGPLv2 COPYING.LGPLv3 ChangeLog INSTALL NEWS README users-manual samples
%{_bindir}/ecell3-em2eml
%{_bindir}/ecell3-eml2em
%{_bindir}/ecell3-eml2sbml
%{_bindir}/ecell3-python
%{_bindir}/ecell3-sbml2eml
%{_bindir}/ecell3-session
%{_bindir}/ecell3-session-manager
%{_libdir}/libecs.so.*
%{_libdir}/libemc.so.*
%{_libdir}/ecell-3.2/dms
%{_libdir}/python*
%ifarch x86_64 ppc64 sparc64
%{python_sitelib}/*
%endif

%files devel
%defattr(-,root,root)
%doc AUTHORS COPYING README api
%{_bindir}/dmcompile
%{_bindir}/ecell3-dmc
%{_includedir}/dmtool
%{_includedir}/ecell-3.2
%{_datadir}/ecell-3.2/dms
%{_libdir}/libecs.so
%{_libdir}/libecs.la
%{_libdir}/libemc.so
%{_libdir}/libemc.la

%files session-monitor
%defattr(-,root,root)
%doc AUTHORS COPYING README
%{_sysconfdir}/ecell-3.2/osogo.ini
%{_bindir}/ecell3-session-monitor
%{_libdir}/ecell-3.2/session-monitor
%{_datadir}/ecell-3.2/session-monitor

%files model-editor
%defattr(-,root,root)
%doc AUTHORS COPYING README model-editor
%{_sysconfdir}/ecell-3.2/model-editor.ini
%{_bindir}/ecell3-model-editor
%{_libdir}/ecell-3.2/model-editor
%{_datadir}/ecell-3.2/model-editor

%changelog
* Wed Jun 30 2010 Moriyoshi Koizumi <mozo@riken.jp>
- Upstream update.

* Tue Feb 05 2008 Moriyoshi Koizumi <mozo@sfc.keio.ac.jp>
- Add pygtk2-libglade to ecell3-model-editor dependencies.
- Add ecell3-session-monitor to ecell3-model-editor dependencies.
- Remove gnome-python2-canvas from ecell3-session-monitor dependencies.

* Fri Dec 21 2007 Moriyoshi Koizumi <mozo@sfc.keio.ac.jp>
- Add pygtk2 to building requirements.

* Fri Dec 21 2007 Moriyoshi Koizumi <mozo@sfc.keio.ac.jp>
- Reorganize package system for E-Cell 3.1.106 release.

* Mon May 31 2004 Takeshi Sakurada <sakurada@e-cell.org>
- The list of requires was modified for the recent Fedora Core environment. 

* Sun Oct 13 2002 Takeshi Sakurada <sakurada@e-cell.org>
- Initial build.

