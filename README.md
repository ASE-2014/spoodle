#SPOODLE

[spoodle.herokuapp.com](http://spoodle.herokuapp.com)

##Documentation
* Installation manual: see below
* [Slides 1. Presentation (idea)](/doc/idea_spoodle_presentation.ppt)
* [Slides 2. Presentation (final)](/doc/final_spoodle_presentation.ppt)
* [SCRUM: Product backlog & Sprint burndown charts](/doc/SCRUM.xls)
* [Screencast of SPOODLE demo](https://www.dropbox.com/s/koop915sjd4vc19/SPOODLE_SCREENCAST.mov?dl=0)

##Installation
1. [Install Ruby 1.9.3 or higher](https://www.ruby-lang.org/en/documentation/installation/) if not already installed.
2. Install Bundler:

   ```ruby
   gem install bundler
   ```

3. Clone this repository.

4. Ask a [contributor](https://github.com/ASE-2014/spoodle/graphs/contributors) for the ```secrets.yml```file (if you haven't already received it) and copy it to the ```/config``` directory.

5. Navigate to the root directory of the repository in terminal or a command line tool.

6. Install gems:

   ```ruby
   bundle install
   ```

7. Setup database and fill it with seeds:

  ```ruby
   rake db:migrate
   rake db:seed
   ```

8. Start rails server:

   ```ruby
   rails s
   ```
   
9. Navigate to ```http://localhost:3000/```with a browser.

10. Enjoy!

# For devs

## **Help, Rails is fu**ing magic! I don't get it!**
**-->** [**Check out the rails guide, read every page and you will understand the magic**](http://guides.rubyonrails.org/index.html) **<--**

## Coding guidelines
Ruby: https://github.com/bbatsov/ruby-style-guide  
Rails: https://github.com/bbatsov/rails-style-guide  
Markdown(for issues on GitHub and so on): https://help.github.com/categories/writing-on-github/


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
