# Readme

This project will display the results of a tournament with images along with commentary.

## Setup

Requires ruby, node, yarn
(See `.tool-versions` and `package.json` for most uptodate versions)

```bash
$ gem install bundler
$ bundle
$ yarn
```

`$ createuser gellaho_tournament -P -s`

Make the password for this new user `gellaho_tournament`

```
$ bundle exec rails db:create
$ bundle exec rails db:migrate
```

## Run

`$ bundle exec rails s`

## Adding a Tournament

Go to `localhost:3000/tournaments/new` (username and password is "test" by default)

Upload a `.zip` file containing one `.json` file of the following format and a bunch of images (A sample can be found at https://gellaho.com/archives/4-tournament-example):

```json
{
  "name": "title of tournament",
  "category": "type of tournament",
  "entrants": [
    {
      "tournament_id": "unique identifier within file",
      "creator": "who made it",
      "name": "title of image",
      "image": "name of image.png"
    },
    ...
  ],
  "commentators": [
    {
      "tournament_id": "",
      "name": "",
      "image": ""
    },
    ...
  ],
  "commentary": [
    {
      "commentator": "",
      "text": ""
     },
     ...
  ],
  "rounds": [
    {
      "name": "",
      "number": null,
      "matches": [
        {
          "entrants": ["", ...]
          "winner": "",
          "commentary": [
            {
              "commentator": "",
              "text": ""
            },
            ...
          ]
        },
        ...
      ]
    },
    ...
  ]
}
```

All `"commentators"` and `"commentary"` fields are optional.




The `tournament_id`s are used to identify which entrants/commentators are in each match. This is so you don't have to type out the names every single time. These will not be used in the databse anywhere, it's just used for identification in the importer (See `app/services/TournamentImporter.rb`).

### Example Images

![image](https://github.com/gellaho/gellaho_tournament/assets/3290267/d4a74e68-7b73-4327-a291-c0c379b7b44e)

![image](https://github.com/gellaho/gellaho_tournament/assets/3290267/5ff18c08-857d-4117-a217-c6699c6d15d9)

