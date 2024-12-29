# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Rails.env.development?
  require "factory_bot_rails"

  include FactoryBot::Syntax::Methods

  admins = [
    {
      first_name: "Admin",
      last_name: "User",
      email: "admin@test.com",
      password: "password",
      password_confirmation: "password"
    },
    {
      first_name: "Felipe",
      last_name: "Murakami",
      email: "fm@test.com",
      password: "imanadmin",
      password_confirmation: "imanadmin"
    }
  ].map do |attributes|
    create(:user_admin, attributes)
  end

  groups = [
    { name: "Group 1", user_admin_id: admins.first.id },
    { name: "Group 2", user_admin_id: admins.first.id },
    { name: "Control", user_admin_id: admins.second.id },
    { name: "Experimental", user_admin_id: admins.second.id }
  ].map do |attributes|
    create(:grouping, attributes)
  end

  participants = [
    {
      first_name: "John",
      last_name: "Doe",
      birth_date: "1990-01-01",
      user_admin_id: admins.first.id,
      grouping_id: groups.first.id
    },
    {
      first_name: "Jane",
      last_name: "Doe",
      birth_date: "1990-01-01",
      user_admin_id: admins.first.id,
      grouping_id: groups.second.id
    },
    {
      first_name: "Cool",
      last_name: "Participant",
      birth_date: "2015-01-01",
      user_admin_id: admins.second.id,
      grouping_id: groups.third.id
    },
    {
      first_name: "Nice",
      last_name: "Participant",
      birth_date: "2015-01-01",
      user_admin_id: admins.second.id,
      grouping_id: groups.third.id
    },
    {
      first_name: "Awesome",
      last_name: "Participant",
      birth_date: "2015-01-01",
      user_admin_id: admins.second.id,
      grouping_id: groups.last.id
    }
  ].map do |attributes|
    create(:user_participant, attributes)
  end

  collections = [
    { name: "Collection 1", equations_quantity: 10, user_admin_id: admins.first.id },
    { name: "Pre-test", equations_quantity: 4, user_admin_id: admins.second.id }
  ].map do |attributes|
    create(:collection, attributes)
  end

  equations = [
    {
      user_admin_id: admins.first.id,
      position_a: 2,
      operator: "+",
      position_b: 2,
      position_c: 4,
      unknown_position: "a"
    },
    {
      user_admin_id: admins.second.id,
      position_a: 2,
      operator: "+",
      position_b: 2,
      position_c: 4,
      unknown_position: "a"
    },
    {
      user_admin_id: admins.second.id,
      position_a: 2,
      operator: "*",
      position_b: 2,
      position_c: 4,
      unknown_position: "b"
    },
    {
      user_admin_id: admins.second.id,
      position_a: 2,
      operator: "-",
      position_b: 2,
      position_c: 0,
      unknown_position: "c"
    },
    {
      user_admin_id: admins.second.id,
      position_a: 2,
      operator: "/",
      position_b: 2,
      position_c: 1,
      unknown_position: "a"
    }
  ].map do |attributes|
    create(:equation, attributes)
  end

  collections_equations = []

  (1..4).each do |i|
    collections_equations << create(
      :collection_equation,
      collection: collections.second,
      equation: equations[i]
    )
  end

  rounds = [
    create(
      :round,
      collection: collections.second,
      participant: participants.third
    ),
    create(
      :round,
      :uncompleted,
      collection: collections.second,
      participant: participants.fourth
    )
  ]

  collections.second.equations_quantity.times do |i|
    if i != 2
      create(
        :answer,
        participant: participants.third,
        collection_equation: collections_equations[i],
        round: rounds.first,
        answer_value: equations[i + 1][:"position_#{equations[i + 1].unknown_position}"], # i + 1 to skip the first equation from the other admin
        correct_answer: true,
        time_spent: rand(10..30).seconds.in_milliseconds
      )
    else
      create(
        :answer,
        participant: participants.third,
        collection_equation: collections_equations[i],
        round: rounds.first,
        answer_value: 3,
        correct_answer: false
      )
    end
  end

  report = create(
    :report,
    user_admin: admins.second,
    collection: collections.second,
    grouping: groups.third
  )

  rounds.first.update(report: report)
end
