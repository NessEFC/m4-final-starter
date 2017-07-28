# URLockBox

This app was created as part of the final assessment for the Turing School of Software and Design Back-end program, and is built using Rails. URLockBox serves as a way to create links with a title and URL, which users can then mark as read or search through using several filtering features. An external service for the app--known as Hot Reads--stores the top 10 read links which are then reflected on the URLockBox homepage by marking top links as "Hot" or "Top Link" (if the link is number one on the Hot Reads site).

The URLockBox production app can be found here: [URLockBox Site](https://polar-plateau-61904.herokuapp.com/)

The Hot Reads repo can be found here: [Hot Reads Repo](https://github.com/NessEFC/hot_reads)

The Hot Reads production app can be found here: [Hot Reads Site](https://obscure-caverns-10564.herokuapp.com/)


## Getting Started

To run this project locally:
```
git clone git@github.com:NessEFC/m4-final-starter.git
cd m4-final-starter
bundle
rake db:create
rake db:migrate
rails s
```
Navigate to `localhost:3000` for the development environment.


## Author

Craig Ness
