## Nebula-3rdparty
**Nebula-3rdparty** is the third party dependency of nebula

## How can I build and install third party ##

### get code
Currently, we using `git-lfs` to manage the 3rd-party libraries. So make sure `git-lfs` have been installed before building the source code.

Please see [INSTALLING.md](https://github.com/git-lfs/git-lfs/blob/master/INSTALLING.md) for more details.

```
git clone git@github.com:vesoft-inc/nebula-3rdparty.git
```
### build
```
cd nebula-3rdparty
cmake ./
make
```
### install
The third-party was installed to /opt/nebula/third-party

```
sudo make install
```
### package
If you want to get the target files into tar.gz, you can do

```
./package.sh
```
