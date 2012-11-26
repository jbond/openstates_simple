namespace :db do
  namespace :legislators do
      desc "TODO"
      task :load => :environment do
        Legislator.load('db/data/ia_legislators.csv')
    end
  end
end
