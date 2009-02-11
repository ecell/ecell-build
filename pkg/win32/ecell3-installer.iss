; Inno Setup script to create E-Cell Simulation Environment Version 3 Installer
; Author: Satya Arjunan <satya@sfc.keio.ac.jp>
; Requires Inno Setup QuickStart Pack 4.2.2 (comes with ISTool script editor and Inno Setup Preprocessor)

; Compilation Instructions:
; 1. Open this file in Inno Setup Compiler
; 2. Under [Setup], set Compression=None during development/test compilation.
;    Set Compression=lzma/ultra for releases.
; 3. Compile the script
; 4. The compiled installer will appear in the root directory of this script file
;
; For more information, please refer to: http://moin.e-cell.org/CreatingWindowsInstaller


#define Stage         GetEnv('STAGE')
#define LicenseFile   Stage + '\doc\COPYING.GPLv2'

[Setup]
AppName=E-Cell Simulation Environment
AppVerName=E-Cell Simulation Environment {#Version}
AppPublisher=Keio University
AppPublisherURL=http://www.e-cell.org/
AppSupportURL=http://sourceforge.net/forum/forum.php?forum_id=247258
AppUpdatesURL=http://sourceforge.net/project/showfiles.php?group_id=72485
DefaultDirName={pf}\E-Cell
DefaultGroupName=E-Cell
SetupIconFile=ecell3-installer.ico
UninstallDisplayIcon={app}\bin\ecell.ico
UninstallDisplayName=E-Cell Simulation Environment {#Version}
ChangesAssociations=yes
OutputBaseFilename=ecell-{#Version}.{#Platform}
OutputDir=.
PrivilegesRequired=none
Compression=none
LicenseFile = {#LicenseFile}
;Compression=lzma/ultra
WizardSmallImageFile=installer_header.bmp
WizardImageFile=installer_intro.bmp
WizardImageStretch=no
BackColor=clBlue
BackColor2=clBlack
BackColorDirection=lefttoright
WizardImageBackColor=clWhite

[Tasks]
Name: desktopicon; Description: Create &desktop icons; GroupDescription: Additional icons:

[Components]
Name: "rt"; Description: "E-Cell SE Runtime"; Types: full compact custom; Flags: fixed;
Name: "fe"; Description: "Python Frontends"; Types: full compact; Check: IsPythonInstalled() and IsNumPyInstalled();
Name: "fe/cli"; Description: "Command-line tools"; Types: full compact; Check: IsPythonInstalled() and IsNumPyInstalled();
Name: "fe/sm"; Description: "Session Monitor"; Types: full compact; Check: IsPyGtkInstalled(); Flags: dontinheritcheck;
Name: "fe/me"; Description: "Model Editor"; Types: full; Check: IsPyGtkInstalled(); Flags: dontinheritcheck;
Name: "dev"; Description: "Development files (C++ header files and import libraries)"; Types: full;

[Files]
;E-Cell libraries
Source: {#Stage}\bin\libgnomecanvas-2-0.dll; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/me;
Source: {#Stage}\bin\gsl.dll; DestDir: {app}\bin; Flags: onlyifdoesntexist ignoreversion; Components: rt;
Source: {#Stage}\bin\ecs.dll; DestDir: {app}\bin; Flags: onlyifdoesntexist ignoreversion; Components: rt;
Source: {#Stage}\bin\emc.dll; DestDir: {app}\bin; Flags: onlyifdoesntexist ignoreversion; Components: rt;
Source: {#Stage}\bin\cblas.dll; DestDir: {app}\bin; Flags: onlyifdoesntexist ignoreversion; Components: rt;
Source: {#Stage}\bin\boost_python*.dll; DestDir: {app}\bin; Flags: ignoreversion; Components: fe;
Source: {#Stage}\bin\ecell3-session-monitor; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/sm;
Source: {#Stage}\bin\ecell3-session-monitor.cmd; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/sm;
Source: {#Stage}\bin\ecell3-session-manager; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;
Source: {#Stage}\bin\ecell3-session-manager.cmd; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;
Source: {#Stage}\bin\ecell3-session; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;
Source: {#Stage}\bin\ecell3-session.cmd; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;
Source: {#Stage}\bin\ecell3-sbml2eml; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;
Source: {#Stage}\bin\ecell3-sbml2eml.cmd; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;
Source: {#Stage}\bin\ecell3-model-editor; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/me;
Source: {#Stage}\bin\ecell3-model-editor.cmd; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/me;
Source: {#Stage}\bin\ecell3-eml2sbml; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;
Source: {#Stage}\bin\ecell3-eml2sbml.cmd; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;
Source: {#Stage}\bin\ecell3-eml2em; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;
Source: {#Stage}\bin\ecell3-eml2em.cmd; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;
Source: {#Stage}\bin\ecell3-em2eml; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;
Source: {#Stage}\bin\ecell3-em2eml.cmd; DestDir: {app}\bin; Flags: ignoreversion; Components: fe/cli;

Source: {#Stage}\include\ltdl.h; DestDir: {app}\include; Flags: ignoreversion; Components: dev;
Source: {#Stage}\include\{#PkgLibDir}\*.*; DestDir: {app}\include\{#PkgLibDir}; Flags: recursesubdirs ignoreversion; Components: dev;
Source: {#Stage}\include\dmtool\*.*; DestDir: {app}\include\dmtool; Flags: recursesubdirs ignoreversion; Components: dev;
Source: {#Stage}\include\gsl\*.*; DestDir: {app}\include\gsl; Flags: recursesubdirs ignoreversion; Components: dev;
Source: {#Stage}\include\boost\*.*; DestDir: {app}\include\boost; Flags: recursesubdirs ignoreversion; Components: dev;
Source: {#Stage}\lib\boost_python*.lib; DestDir: {app}\lib; Flags: ignoreversion; Components: dev;
Source: {#Stage}\lib\ltdl.lib; DestDir: {app}\lib; Flags: ignoreversion; Components: dev;
Source: {#Stage}\lib\gsl.lib; DestDir: {app}\lib; Flags: ignoreversion; Components: dev;
Source: {#Stage}\lib\cblas.lib; DestDir: {app}\lib; Flags: ignoreversion; Components: dev;
Source: {#Stage}\lib\ecs.lib; DestDir: {app}\lib; Flags: ignoreversion; Components: dev;
Source: {#Stage}\lib\emc.lib; DestDir: {app}\lib; Flags: ignoreversion; Components: dev;

Source: {#Stage}\lib\site-packages\gnomecanvas.pyd; DestDir: {app}\lib\site-packages; Flags: ignoreversion; Components: fe/me;
Source: {#Stage}\lib\site-packages\E_Cell*.egg-info; DestDir: {app}\lib\site-packages; Flags: recursesubdirs ignoreversion; Components: fe;
Source: {#Stage}\lib\site-packages\ecell\*.*; DestDir: {app}\lib\site-packages\ecell; Flags: recursesubdirs ignoreversion; Components: fe;
Source: {#Stage}\lib\{#PkgLibDir}\dms\*.*; DestDir: {app}\lib\{#PkgLibDir}\dms; Flags: recursesubdirs ignoreversion; Components: rt;
Source: {#Stage}\lib\{#PkgLibDir}\model-editor\*.*; DestDir: {app}\lib\{#PkgLibDir}\model-editor; Flags: recursesubdirs ignoreversion; Components: fe/me;
Source: {#Stage}\lib\{#PkgLibDir}\session-monitor\*.*; DestDir: {app}\lib\{#PkgLibDir}\session-monitor; Flags: recursesubdirs ignoreversion; Components: fe/sm;
Source: {#Stage}\doc\*.*; DestDir: {app}\doc; Flags: recursesubdirs ignoreversion
Source: ecell.ico; DestDir: {app}; Flags: ignoreversion

Source: {#GeneratedSampleEmlDir}\simple\simple.eml; DestDir: {app}\doc\samples\simple;
Source: {#GeneratedSampleEmlDir}\branchG\branchG.eml; DestDir: {app}\doc\samples\branchG;
Source: {#GeneratedSampleEmlDir}\CoupledOscillator\cascade.eml; DestDir: {app}\doc\samples\CoupledOscillator;
Source: {#GeneratedSampleEmlDir}\Drosophila\Drosophila.eml; DestDir: {app}\doc\samples\Drosophila;
Source: {#GeneratedSampleEmlDir}\Drosophila-cpp\Drosophila.eml; DestDir: {app}\doc\samples\Drosophila-cpp;
Source: {#GeneratedSampleEmlDir}\Heatshock\heatshock.eml; DestDir: {app}\doc\samples\Heatshock;
Source: {#GeneratedSampleEmlDir}\LTD\LTD.eml; DestDir: {app}\doc\samples\LTD;
Source: {#GeneratedSampleEmlDir}\Pendulum\Pendulum.eml; DestDir: {app}\doc\samples\Pendulum;
Source: {#GeneratedSampleEmlDir}\SSystem\SSystem.eml; DestDir: {app}\doc\samples\SSystem;
Source: {#GeneratedSampleEmlDir}\Toy_Hybrid\Toy_Hybrid.eml; DestDir: {app}\doc\samples\Toy_Hybrid;

[Icons]
;Main E-Cell icons in Start Menu
Name: {group}\README; Filename: "write.exe"; Parameters: """{app}\doc\README"""; WorkingDir: {app}; IconFilename: {app}\ecell.ico;
Name: {group}\E-Cell Session; Filename: {app}\bin\ecell3-session.cmd; IconFilename: {app}\ecell.ico; Components: fe/cli;
Name: {group}\E-Cell Session Manager; Filename: {app}\bin\ecell3-session-manager.cmd; IconFilename: {app}\ecell.ico; Components: fe/cli;
Name: {group}\E-Cell Session Monitor; Filename: {app}\bin\ecell3-session-monitor.cmd; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/sm;
Name: {group}\E-Cell Model Editor; Filename: {app}\bin\ecell3-model-editor.cmd; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/me;

;E-Cell sample icons in Start Menu
Name: {group}\Samples\Simple; Filename: {app}\bin\ecell3-session-monitor.cmd; Parameters: -f doc\samples\simple\simple.eml; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/sm;
Name: {group}\Samples\BranchG; Filename: {app}\bin\ecell3-session-monitor.cmd; Parameters: -f doc\samples\branchG\branchG.eml; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/sm;
Name: {group}\Samples\CoupledOscillator; Filename: {app}\bin\ecell3-session-monitor.cmd; Parameters: -f doc\samples\CoupledOscillator\cascade.eml; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/sm;
Name: {group}\Samples\Drosophila; Filename: {app}\bin\ecell3-session-monitor.cmd; Parameters: -f doc\samples\Drosophila\Drosophila.eml; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/sm;
Name: {group}\Samples\Drosophila-cpp; Filename: {app}\bin\ecell3-session-monitor.cmd; Parameters: -f doc\samples\Drosophila-cpp\Drosophila.eml; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/sm;
Name: {group}\Samples\Heatshock; Filename: {app}\bin\ecell3-session-monitor.cmd; Parameters: -f doc\samples\Heatshock\heatshock.eml; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/sm;
Name: {group}\Samples\LTD; Filename: {app}\bin\ecell3-session-monitor.cmd; Parameters: -f doc\samples\LTD\LTD.eml; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/sm;
Name: {group}\Samples\Pendulum; Filename: {app}\bin\ecell3-session-monitor.cmd; Parameters: -f doc\samples\Pendulum\Pendulum.eml; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/sm;
Name: {group}\Samples\SSystem; Filename: {app}\bin\ecell3-session-monitor.cmd; Parameters: -f doc\samples\SSystem\SSystem.eml; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/sm;
Name: {group}\Samples\Toy_Hybrid; Filename: {app}\bin\ecell3-session-monitor.cmd; Parameters: -f doc\samples\Toy_Hybrid\Toy_Hybrid.eml; WorkingDir: {app}; IconFilename: {app}\ecell.ico; Components: fe/sm;

;Main E-Cell shortcuts in Desktop
Name: {userdesktop}\E-Cell Session Monitor; Filename: {app}\bin\ecell3-session-monitor.cmd; WorkingDir: {app}; Tasks: desktopicon; IconFilename: {app}\ecell.ico; Components: fe/sm;
Name: {userdesktop}\E-Cell Model Editor; Filename: {app}\bin\ecell3-model-editor.cmd; WorkingDir: {app}; Tasks: desktopicon; IconFilename: {app}\ecell.ico; Components: fe/me;

[Messages]
FinishedLabel=Please wait for a few moments while setup finalizes E-Cell {#Version} installation on your computer.

[LangOptions]
TitleFontName=Verdana
TitleFontSize=26
DialogFontName=Tahoma

[UninstallDelete]
Type: filesandordirs; Name: {app}\lib

[Code]
type Installation = record
  version: String;
  path: String;
end;

const
  ARCHITECTURE   =  '{#Platform}';
  ECELL_VERSION  =  '{#Version}';
  LICENSE_FILE   =  '{#LicenseFile}';
  PYTHON_VERSION =  '{#PythonVersion}';
  GTK_VERSION    =  '{#GtkVersion}';
  NUMPY_VERSION  =  '{#NumPyVersion}';
var
  URLLabel: TNewStaticText;
  InstalledComponentsPage: TOutputMsgMemoWizardPage;
  PythonInstallation: Installation;
  GtkInstallation: Installation;
  PyGtkInstalled: Boolean;
  NumPyInstalled: Boolean;

function IsPythonInstalled(): Boolean;
begin
  Result := PythonInstallation.version <> '';
end;

function IsGtkInstalled(): Boolean;
begin
  Result := GtkInstallation.version <> '';
end;

function IsPyGtkInstalled(): Boolean;
begin
  Result := PyGtkInstalled;
end;

function IsNumPyInstalled(): Boolean;
begin
  Result := NumPyInstalled;
end;

function Split(s, delimiter: String): TArrayOfString;
var
  i, next: Integer;
begin
  i := 0;
  next := 1;
  while Length(s) > 0 do begin
    next := Pos(delimiter, s);
    if next = 0 then next := Length(s) + 1
    SetArrayLength(Result, i + 1);
    Result[i] := Copy(s, 1, next - 1);
    Delete(s, 1, next);
    i := i + 1
  end;
end;

function CompareVersion(const a, b: String): Integer;
var
  aComps, bComps: TArrayOfString;
  aLen, bLen, i, aComp, bComp: Integer;
begin
  aComps := Split(a, '.');
  bComps := Split(b, '.');
  aLen := GetArrayLength(aComps);
  bLen := GetArrayLength(bComps);
  Result := 0;
  for i := 0 to aLen - 1 do begin
    aComp := StrToInt(aComps[i]);
    if i < bLen then bComp := StrToInt(bComps[i]) else bComp := 0;
    if aComp < bComp then begin
      Result := -1;
      break;
    end;
    if aComp > bComp then begin
      Result := 1;
      break;
    end;
  end;
  if (Result = 0) and (aLen < bLen) then Result := -1;
end;

function CheckPythonInstallation(): Installation;
var
  versions: TArrayOfString;
  pythonDir  : String;
  i          : Integer;
begin
  Result.version := '';
  Result.path := '';
  { Check if Python has been installed, if it meets a minimum version, and if python.exe exists }
  if RegGetSubkeyNames(HKLM, 'Software\Python\PythonCore', versions) then begin
    for i := 0 to GetArrayLength(versions) - 1 do begin
      if CompareVersion(versions[i], PYTHON_VERSION) >= 0 then begin
        RegQueryStringValue(HKLM, 'Software\Python\PythonCore\' + versions[i] + '\InstallPath', '', pythonDir)
        if FileExists(pythonDir + '\python.exe') then begin
          Result.version := versions[i]
          Result.path := pythonDir
        end;
      end;
    end;
  end;
  if (Result.version = '') and RegGetSubkeyNames(HKCU, 'Software\Python\PythonCore', versions) then begin
    for i := 0 to GetArrayLength(versions) - 1 do begin
      if CompareVersion(versions[i], PYTHON_VERSION) >= 0 then begin
        RegQueryStringValue(HKCU, 'Software\Python\PythonCore\' + versions[i] + '\InstallPath', '', pythonDir)
        if FileExists(pythonDir + '\python.exe') then begin
          Result.version := versions[i]
          Result.path := pythonDir
        end;
      end;
    end;
  end;
end;

function CheckGtkInstallation(): Installation;
var
  gtkDir: String;
  version: String;
begin
  Result.version := '';
  Result.path := '';
  { Check if GTK has been installed, if it meets a minimum version, and if libglib-2.0-0.dll exists }
  if RegQueryStringValue(HKLM, 'Software\GTK\2.0', 'Version', version) then
    RegQueryStringValue(HKLM, 'Software\GTK\2.0', 'Path', gtkDir)
  else
    if RegQueryStringValue(HKCU, 'Software\GTK\2.0', 'Version', version) then
      RegQueryStringValue(HKCU, 'Software\GTK\2.0', 'Path', gtkDir);

  if version <> '' then begin
    if CompareVersion(version, GTK_VERSION) >= 0 then begin
      if FileExists(gtkDir + '\bin\libglib-2.0-0.dll') then begin
        Result.version := version;
        Result.path := gtkDir;
      end;
    end;
  end;
end;

function CheckPyGtkInstalled(pythonHome: String): Boolean;
var
  resultCode: Integer;
begin
  Result := False
  if Exec(AddBackslash(pythonHome) + 'python.exe', '-c "import pygtk"', '', SW_HIDE, ewWaitUntilTerminated, resultCode) then
    if resultCode = 0 then Result := True;
end;

function CheckNumPyInstalled(pythonHome: String): Boolean;
var
  resultCode: Integer;
begin
  Result := False
  if Exec(AddBackslash(pythonHome) + 'python.exe', '-c "import numpy; import sys; from distutils.version import StrictVersion; sys.exit(StrictVersion(numpy.version.version) < StrictVersion(''' + NUMPY_VERSION + ''') and 1 or 0)"', '', SW_HIDE, ewWaitUntilTerminated, resultCode) then
    if resultCode = 0 then Result := True;
end;

procedure URLLabel_OnClick(Sender: TObject);
var
  Dummy: Integer;
begin
  URLLabel.Font.Color := clBlack;
  ShellExec('', 'http://www.e-cell.org/', '', '', SW_SHOWNORMAL, ewNoWait, Dummy);
end;

procedure InstalledComponentsPage_OnActivate(Sender: TWizardPage);
begin
  { WizardForm.NextButton.Enabled := False; }
end;

function InitializeSetup(): Boolean;
begin
  GtkInstallation := CheckGtkInstallation();
  PythonInstallation := CheckPythonInstallation();
  if PythonInstallation.version <> '' then begin
    PyGtkInstalled := CheckPyGtkInstalled(PythonInstallation.path);
    NumPyInstalled := CheckNumPyInstalled(PythonInstallation.path);
  end 
  else begin
    PyGtkInstalled := False;
    NumPyInstalled := False;
  end;
  Result := True
end;

procedure InitializeWizard();
var
  cancelButton: TButton;
  msg: String;
begin
  cancelButton := WizardForm.cancelButton;
  URLLabel := TNewStaticText.Create(WizardForm);
  URLLabel.Top := cancelButton.Top + cancelButton.Height - URLLabel.Height - 2;
  URLLabel.Left := WizardForm.ClientWidth - cancelButton.Left - cancelButton.Width;
  URLLabel.Caption := 'http://e-cell.org/';
  URLLabel.Font.Name := 'Verdana';
  URLLabel.Font.Size := 7;
  URLLabel.Font.Color := clBlue;
  URLLabel.Cursor := crHand;
  URLLabel.OnClick := @URLLabel_OnClick;
  URLLabel.Parent := WizardForm;

  msg := '';

  if PythonInstallation.version <> '' then
    msg := msg + 'Python (version: ' + PythonInstallation.version + ') is installed under ' + PythonInstallation.path + Chr(13) + Chr(10)
  else
    msg := msg + 'Python (version >= ' + PYTHON_VERSION + ') is not installed.' + Chr(13) + Chr(10);

  if GtkInstallation.version <> '' then
    msg := msg + 'GTK+ (version: ' + GtkInstallation.version + ') is installed under ' + GtkInstallation.path + Chr(13) + Chr(10)
  else
    msg := msg + 'GTK+ (version >= ' + GTK_VERSION + ') is not installed.' + Chr(13) + Chr(10);

  if NumPyInstalled then
    msg := msg + 'NumPy is installed' + Chr(13) + Chr(10)
  else
    msg := msg + 'NumPy is not installed.' + Chr(13) + Chr(10);

  if PyGtkInstalled then
    msg := msg + 'PyGTK is installed' + Chr(13) + Chr(10)
  else
    msg := msg + 'PyGTK is not installed.' + Chr(13) + Chr(10);

  InstalledComponentsPage := CreateOutputMsgMemoPage(wpLicense,
    'Checks for required components', 'Checking the installation of components that are required by E-Cell SE.',
    '', msg);
  InstalledComponentsPage.OnActivate := @InstalledComponentsPage_OnActivate;

end;
