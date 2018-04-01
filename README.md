# Kalkulus Masternode Controller Box

![Kalkulus logo](/img/logo_header.png)

A guide and toolbox to setup a masternode controller VM for Kalkulus in the most convenient way.


## Tools used

This setup is designed around Vagrant. Vagrant is an open source tool from the DevOps world that is often used to provision development environments automatically. 

![The final result](/img/vm_window.png)

You need the following set of tools to start:  

* VirtualBox (newest version from the [VirtualBox-Homepage])
* Vagrant (newest version from the [Vagrant-Homepage])
* **Only on Windows**: Git for Windows (newest version from the [Git-Homepage])

## Start of the environment

The `Vagrantfile` in this repository contains the complete configuration of the environment. This means the definition of the Linux distribution, the networking parameter, packages to install and many things more. Check the Vagrant documentation for pointers whats possible.

> Since the configuration of Vagrant and the environment to create is all part of the source (git) repository, the environment can easily be destroyed and re-created within a couple of minutes.

### Clone the repo

Exactly like with any other development workflow,  the initialisation of this environment is created by checking out this source code repository.
```sh
   git clone https://github.com/marsmensch/kalkulus-masternode-controller.git
```

### One command to rule them all

In a console (for Windows use `Git-Bash`) open the cloned directory `kalkulus-masternode-controller` and execute the **one and only required command to create the environment**:

```sh
   vagrant up
```

No kidding, that's it!

What happens now is a bit of DevOps magic. **After a couple of minutes**, the following things happened:

* Vagrant created and configured a virtual machine via VirtualBox
* A couple of shell scripts installed the required packages
* Vagrant automatically configures a couple of useful shortcuts like a shared folder in `/vagrant` with the host system and convenient passwordless logins via SSH Keys to the VM. 
* The Kalkulus-Qt wallet is compiled from source (or a binary release from the 'bin' directory is used
* The official nodes are added to the configuration file at `/home/vagrant/.klks/klks.conf`
* A Shortcut is placed on your desktop

>         The box has 2048 MB of RAM and 2 CPU cores assigned.
>         Change that in the `Vagrantfile` if you want more or less RAM/CPU.

The VM GUI window is also shown for your convenience (Vagrant normally hides it), so you can login graphically and test e.g. graphical wallets.

## Connect to your VM

Connecting to your VM is as easy as run a command in a terminal / (power)shell . You need exactly one command to connect:

```sh
   vagrant ssh
```

> For SSH connections Vagrant looks for a SSH client (`ssh.exe`) in your $PATH. This is already the case for OSX and Linux. On Windows you want to install Git for Windows for this.

## Working with your new VM

As noted above, the included shell script `vagrant_provision.sh` installs all required packages and compiles + installs the Cream wallet from the git "master" branch sources.

## Starting the VM
- `vagrant up`                  -- starts or resumes the VM (also provisions only on the FIRST vagrant up)

## Getting into a VM
- `vagrant ssh`                 -- connects to machine via SSH

## Stopping a VM
- `vagrant halt`                -- stops the vagrant machine
- `vagrant suspend`             -- suspends a virtual machine (remembers state)

## Cleaning Up a VM
- `vagrant destroy              -- destroys the VM (ATTENTION!) 

# Donations

BTC donations welcome and never forget: Have fun, this is crypto after all!

```
BTC  33ENWZ9RCYBG7nv6ac8KxBUSuQX64Hx3x3
```

[Git-Homepage]: <https://github.com/git-for-windows/git/releases/latest>
[VirtualBox-Homepage]: <https://www.virtualbox.org/wiki/Downloads>
[Vagrant-Homepage]: <https://www.vagrantup.com/downloads.html>
[Kalkulus-Homepage]: <http://kalkulus.trade/>