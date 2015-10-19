Records Uploader
=======================

### :hash: App description
-------------
This app lets you, to open 'xls' and 'xlsx' files loacated in 'lib/tasks/' directory and upload users from Exel files directly to the app db, along with creating corresponding accounts for them. 

 | Name |  Version |
| :--: | :---: |
| [Ruby](https://www.ruby-lang.org) | 2.2.0 |
| [Ruby on Rails](http://www.rubyonrails.org/) | 4.2.1 |

### :book: How to use
-------------
1. add desired 'xls` or 'xlsx' file to the 'lib/tasks/' directory,
2. upload accounts from the console by typing: 'rake exel:upload_users',

### :warning: What disqualifies the object from being uploaded
-------------
* Email is incorrect (@o2.com), or is already taken.
* First name is not present.
* Last name is not resent.
* Validity Date is not at least one day after today. 

### :warning: In order to sign up personally, additional validations must be met:
-------------
* Email must have correct format, and can`t be already taken.
* First name must start with a capital letter, rest must be lowercase, ex: (ToM will return an error)
* Last name must contains of words that starts with a capital letter, rest must be lowercase ex: (Hope or Van Disel or Up-Down are ok).
* Username must contain only lowercase letters, and it must be 8 characters long.
* Password mu be between 6 and 24 characters.
* Validity Date must be dated at least one day after present date.