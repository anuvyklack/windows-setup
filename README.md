Run the following command from PowerShell.
It will run `Windows10-Setup.ps1` script which will setup some Windows settings,
enable WSL2 and install scoop.

``` powershell
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://git.io/winsetup.ps1')
```

or shorter

``` powershell
iwr -useb git.io/winsetup.ps1 | iex
```

-------------------------------------------------------------------------------

# Development version of Ansible


`win_scoop` module will be added only in 2.10 version. So until that need to use
development version:

```sh
git clone https://github.com/ansible/ansible.git --depth 1 ansible-dev
cd ./ansible-dev
source ./hacking/env-setup
# Install prerequisite
conda install --file requirements.txt
# Install latest community.windows collection (for scoop module)
ansible-galaxy collection install git+https://github.com/ansible-collections/community.windows
```

-------------------------------------------------------------------------------

Individual collections can be installed by doing:

```sh
ansible-galaxy collection install NAMESPACE.COLLECTION
```

or, if you need the latest version currently from GitHub:

```sh
ansible-galaxy collection install git+https://github.com/organization/repo_name.git,devel
```

For example `win_scoop` module is in `community.windows` collection:

```sh
ansible-galaxy collection install community.windows
```

or

```sh
ansible-galaxy collection install git+https://github.com/ansible-collections/community.windows
```

-------------------------------------------------------------------------------

Shortened url for installation script: `https://git.io/winsetup.ps1`

-------------------------------------------------------------------------------

Ansible uses the `pywinrm` package to communicate with Windows servers over
WinRM. It is not installed by default with the Ansible package, but can be
installed by running the following:

    pip install 'pywinrm[credssp]'
