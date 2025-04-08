# Doom for the Numworks calculator

> This was forked from the doom source code repo.

> The retry of [a previous project](https://github.com/riley0122/numworks_doom)

> [Another project I found that also ports doom to the NumworksCalculator](https://github.com/CoolLasagna12/doomWorks) (using my template btw :p)

# Building

This projects building toolchain was made for `Ubuntu` (specifically WSL).

In order to build you must have `arm-none-eabi-gcc` and `node` installed.

## Installing `arm-none-eabi-gcc`

> (This is truly a bit of a sidequest)

### Step 1 - Download the latest version

<sup><sub>this guide was derived from [this interaction](https://askubuntu.com/questions/1243252/how-to-install-arm-none-eabi-gdb-on-ubuntu-20-04-lts-focal-fossa)</sub></sup>

Download the latest tarball [from arm](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)

### Step 2 - Unpack the tarball

This can be done with the following command

`sudo tar xjf gcc-arm-none-eabi-YOUR-VERSION.bz2 -C /usr/share/`

Make sure to replace `YOUR-VERSION` with the correct version!

### Step 3 - Make the binaries available

You can make the binaries accessible by running these commands:

```bash
sudo ln -s /usr/share/gcc-arm-none-eabi-YOUR-VERSION/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc 
sudo ln -s /usr/share/gcc-arm-none-eabi-YOUR-VERSION/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++
sudo ln -s /usr/share/gcc-arm-none-eabi-YOUR-VERSION/bin/arm-none-eabi-gdb /usr/bin/arm-none-eabi-gdb
sudo ln -s /usr/share/gcc-arm-none-eabi-YOUR-VERSION/bin/arm-none-eabi-size /usr/bin/arm-none-eabi-size
sudo ln -s /usr/share/gcc-arm-none-eabi-YOUR-VERSION/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy
```

Once again make sure to replace `YOUR-VERSION` with the correct version!


## Installing node

This is also a slight sidequest, however way more managable.

Simply run this script (modified [this script from nodejs.org](https://nodejs.org/en/download))

```bash
# Make sure unzip is available for curl
sudo apt install unzip

# Download and install fnm:
curl -o- https://fnm.vercel.app/install | bash

# source bashrc
source ~/.bashrc

# Download and install Node.js:
fnm install 22

# Verify the Node.js version:
node -v # Should print "v22.14.0".

# Verify npm version:
npm -v # Should print "10.9.2".
```