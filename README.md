# engage-docker

Engage docker-compose configuration to bring up backend and celery tasks

## **Development**

### **Cloning**

To use this in a development setting, make sure you clone this repo with `--recurse-submodules`

That is:
`git clone --recurse-submodules git@github.com:hackla-engage/engage-docker.git`

If you forgot that step, you can just issue `git submodule init` and then `git submodule update`

_Why?_

Because we include two submodules: [engage-backend](https://github.com/hackla-engage/engage-backend] and [engage-celery](git@github.com:hackla-engage/engage-celery.git)

You can do your development in this pulled repository, because in effect you are cloning those two repos. Make sure you create a new branch if you want to do development in either of those repos.

To develop on those submodules, go to GitHub. Make forks of either engage-backend or engage-celery. Add a repository as a `myfork` or some title you'll remember.

For example:

1. Fork engage-backend like I did [here](https://github.com/eselkin/engage-backend)
2. Go to your clone of this repo and enter the engage-backend subdirectory
3. Get the cloning address for your fork. Mine, for example is: git@github.com:eselkin/engage-backend.git
4. Add the remote: `git remote add myfork git@github.com:eselkin/engage-backend.git`
5. Make a new branch `git branch somedevelopmentfeature`
6. Checkout that local branch `git checkout somedevelopmentfeature`
7. Make changes to that submodule
8. Push the branch to your fork: `git push --set-upstream myfork somedevelopmentfeature`
9. Make a pull request from your fork on GitHub.com


### **Running in dev**

We provide a `docker-compose-dev.yml` and a `dev.env`. The docker-compose file uses this environment file for its configuration. Several attributes can be changed but it is recommended that you do not include changes to that file in a PR.

To run:

1. Make sure you have docker and docker-compose on your system
2. Make sure you have enough disk space (We've tried to keep the containers small but it's still space)
3. Make sure you have cloned the repository correctly (see above)
4. Make sure you don't have postgres running on port 5432 on your system (most people don't)
5. Make sure you don't have redis running on port 6379 on your system (most people don't)
6. Make sure you don't have rabbitmq running on your system (most people don't)
7. `docker-compose -f docker-compose-dev.yml build`  # Wait!
8. `docker-compose -f docker-compose-dev.yml up` # Run

Using the configuration from dev.env the scraper will begin scraping agendas after 1 minute and will populate a local database (postgres) running in one of the containers. This is controlled by the environment variable `BEAT_SANTAMONICA_SCRAPE=*`...

If you wish to increase the time between scrapes, change the &ast; to another cron minute interval (i.e. &ast;/5 for every five minutes).

You can log into that postgres container with the username and password from the `dev.env` file. However, in production this would not be possible.

### **Making changes to the submodules**

Since the directories are mounted as volumes in the docker-compose dev yaml, your changes will be present if you issue a `docker-compose -f docker-compose-dev.yml down` and then `up` again. You won't need to build again. If you have altered the requirements.txt files or the Pipfiles in the submodules, it's suggested that you build again.

### See respective submodules for contribution guidelines
