# frozen_string_literal: true

# {
#   "name": "",
#   "category": "",
#   "entrants": [
#     {
#       "tournament_id": "",
#       "creator": "",
#       "name": "",
#       "image": ""
#     },
#     ...
#   ],
#   "commentators": [
#     {
#       "tournament_id": "",
#       "name": "",
#       "image": ""
#     },
#     ...
#   ],
#   "commentary": [
#     {
#       "commentator": "",
#       "text": ""
#      },
#      ...
#   ],
#   "rounds": [
#     {
#       "name": "",
#       "number": null,
#       "matches": [
#         {
#           "entrants": ["", ...]
#           "winner": "",
#           "commentary": [
#             {
#               "commentator": "",
#               "text": ""
#             },
#             ...
#           ]
#         },
#         ...
#       ]
#     },
#     ...
#   ]
# }

require 'zip'

class TournamentImporter
  class << self
    def import(uploaded_file)
      tournament = nil

      Zip::File.open(uploaded_file) do |zip_file|
        tournament_json = JSON.parse(zip_file.glob('*.json').first.get_input_stream.read)

        tournament = create_tournament(tournament_json)
        entrant_map = create_entrants(zip_file, tournament_json, tournament)
        commentator_map = create_commentators(zip_file, tournament_json)

        create_commentary(tournament_json, tournament, commentator_map)

        tournament_json['rounds'].each do |json|
          round = Tournament::Round.create!(name: json['name'], number: json['number'], tournament:)

          create_matches(round, json, entrant_map, commentator_map)
        end
      end

      tournament
    end

    private

    def create_tournament(tournament_json)
      name = tournament_json['name']
      Tournament.where(name:).destroy_all
      Tournament.create!(name:, category: tournament_json['category'])
    end

    def create_entrants(zip_file, tournament_json, tournament)
      tournament_json['entrants'].each_with_object({}) do |json, entrant_map|
        entrant = Tournament::Entrant.create!(name: json['name'], creator: json['creator'], tournament:)

        image = json['image']
        Tempfiler.from_zip(zip_file, image) do |tf|
          entrant.image.attach(io: tf, filename: image)
        end

        entrant_map[json['tournament_id']] = entrant
      end
    end

    def create_commentators(zip_file, tournament_json)
      tournament_json.fetch('commentators', []).each_with_object({}) do |json, commentator_map|
        commentator = Tournament::Commentator.create!(name: json['name'])

        image = json['image']
        Tempfiler.from_zip(zip_file, image) do |tf|
          commentator.image.attach(io: tf, filename: image)
        end

        commentator_map[json['tournament_id']] = commentator
      end
    end

    def create_matches(round, round_json, entrant_map, commentator_map)
      round_json['matches'].each do |json|
        winner = entrant_map[json['winner']]
        match = Tournament::Match.create!(round:, winner:)

        match.entrants = json.fetch('entrants', []).map { |tournament_id| entrant_map[tournament_id] }

        create_commentary(json, match, commentator_map)
      end
    end

    def create_commentary(json, commentable, commentator_map)
      commentary = json.fetch('commentary', []).map do |hash|
        {
          commentator: commentator_map[hash['commentator']],
          text: hash['text']
        }
      end
      commentable.commentaries.create!(commentary)
    end
  end
end
