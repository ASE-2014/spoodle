spoodle
=======

Doodle meets sports


# For devs


## Coding guidelines
Ruby: https://github.com/bbatsov/ruby-style-guide  
Rails: https://github.com/bbatsov/rails-style-guide


## RESTful
* [Advanced REST client](https://chrome.google.com/webstore/detail/advanced-rest-client/hgmloofddffdnphfgcellkdfbfbjeloo?utm_source=gmail)
* [ch.unifr.ase.REST (Rails + REST example)](https://github.com/aruppen/ch.unifr.ase.REST)


## Versions
Ruby v1.9.3  
Rails v4.1.6


## Scrum
* [Scrum file on Google Docs](https://docs.google.com/spreadsheets/d/1fUCD3_R0JQMdiDByQR-dAFa5DUAPoTSOcI2_9BJnZ14/edit#gid=0)


## Git rules
* Always pull before you push  
* [Avoiding Git Disasters](http://randyfay.com/content/avoiding-git-disasters-gory-story)

### Branches
| Branch name | Description | stable? |
| ------------- |:-------------| :-----:|
| **master** | Release versions only (e.g. v0.1, v0.3, v1.0) | always stable |
| **dev** | Finished and working features only | always stable |
| **feature/xyz** | When working on feature xyz | possibly unstable |
| **fix/xyz** | When working on bug xyz | possibly unstable |
| **exp/xyz** | When experimenting on xyz | possibly unstable |

#### Example
![branching rules](http://www.rittmanmead.com/wp-content/uploads/2013/07/git-branch1.png)

#### Commands
|Command | Description |
| ------ | :---------- |
| git merge feature/xyz --no-ff | This ensures that you create a merge commit instead of fast-forwarding. |
