install:
	bundle install
	bin/rails db:migrate
	bundle exec rake db:seed