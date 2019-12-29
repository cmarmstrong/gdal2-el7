#/bin/bash

set -e
SPECFILE=texlive18.spec
cat << EOF > "$SPECFILE"
Name:           texlive-FAKE
Version:        2018
Release:        4%{?dist}
Summary:        Dummy wrapper for manual texlive install
License:        Artistic 2.0 and GPLv2 and GPLv2+ and LGPLv2+ and LPPL and MIT and Public Domain and UCD and Utopia
URL:            http://www.tug.org/texlive/quickinstall.html
Source0:        texlive.profile
#Source1:        http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

BuildRequires:  perl
Requires:       perl
EOF

# add all the texlive package as conflicts and as provided by this
# package >:)

BINARY_PACKAGES=()

while read line; do
    pkg=$(echo "$line" | sed  's/\..*//')
    #echo "$line -> $pkg"
    case "$pkg" in
        "")
            # do nothing, empty
            echo "$line -> $pkg"
            ;;
        texlive-FAKE*)
            # that's us.. ignore
            ;;
        texlive*-bin|texlive*-lib)
            echo "Provides:       $pkg" >> "$SPECFILE"
            echo "Conflicts:      $pkg" >> "$SPECFILE"
            ;;
        texlive*)
            BINARY_PACKAGES+=($pkg)
            ;;
        *)
            # some junk output from 'yum search'
            ;;
    esac
done < <(yum search texlive)

#
# Create a common sub-package
#

cat << EOF >> "$SPECFILE"

%package common
BuildArch:      noarch
Summary:        Dummy wrapper for manual texlive install, binary files
EOF
for pkg in "${BINARY_PACKAGES[@]}" ; do
    echo "Provides:       $pkg" >> "$SPECFILE"
    echo "Conflicts:      $pkg" >> "$SPECFILE"
done

cat << EOF >> "$SPECFILE"

%description

This package just tells rpm/yum/dnf that all texlive packages are
available.  You actually have to install them yourself using the
texlive installer from: http://www.tug.org/texlive/quickinstall.html

%description common
blah

%prep
#%setup -q

%build
#./install-tl -profile texlive.profile %{_bindir}

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}
#install %{_builddir}

%files
%files common

%doc

%changelog
EOF

rpmbuild -ba -v "$SPECFILE"
cp ~/rpmbuild/RPMS/*/texlive*.rpm .
