# gdal2-el7
GDAL 2.x rebuilt from fc29 for el7

# Dependencies
- software collections rh-java-common-javapackages-local, rh-java-common-ant, and rh-maven30
- full texlive from https://www.tug.org/texlive/quickinstall.html
- MariaDB from https://mariadb.com/kb/en/library/yum/

# Installation
Obtain and install dependencies.  Next, run the texlive script to generate a texlive-FAKE rpm.  Alter the script as necessary to match your installation of texlive (change "18" to "17" if you have texlive2017).  Install the resulting texlive-FAKE along with GDAL

```bash
./texlive18.spec.sh
sudo rpm -ivh texlive-FAKE-2018.el7.x86_64.rpm gdal-libs-2.3.1-3.el7.x86_64.rpm gdal-2.3.1-3.el7.x86_64.rpm
```
