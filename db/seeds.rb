# frozen_string_literal: true

# Model Structure
#
# ├── User/
# │   └── Teams (has_many through TeamUser)
# └── Team/
#     ├── Users (has_many through TeamUser)
#     ├── Categories
#     └── Projects/
#         ├── Categories (has_many through CategoryProject)
#         ├── Users (has_many through ProjectUser)
#         ├── Creator (as User; must belong to Team)
#         └── Tasks/
#             └── Assignee (as User; must belong to Project)

team_names = %w[Konohagakure Sunagakure Amegakure Kumogakure Iwagakure]

%w[John Jane Jimmy Janet Dough].each do |name|
  user = User.create(
    first_name: name,
    last_name: 'Doe',
    email: "#{name}@example.com",
    password: '123123', password_confirmation: '123123'
  )

  Team.create(
    team_name: team_names.pop,
    description: 'A realy good description.',
    creator_id: user.id,
    policy: :public
  )
end

# Every team should have at least one user left behind.
Team.where.not(team_name: 'Default').each do |team|
  User.where.not(id: team.creator_id).all.sample(3).each do |user|
    TeamUser.create(
      team_id: team.id,
      user_id: user.id,
      admin: [true, false].sample
    )
  end

  %w[Home Work Miscelaneous].each do |category|
    Category.create(
      category_name: category,
      team_id: team.id
    )
  end

  3.times.each do |i|
    Project.create(
      project_name: "Project #{i}",
      policy: :public,
      progress: 0,
      priority: :low,
      team_id: team.id,
      creator_id: team.members.sample.id,
      due_date: Date.today
    )
  end
end
