# Linux Host Testing - GitHub Workflow
I've settled on this workflow for Linux host testing. It treats the `backend-examplar-2018` as a template, which simplified the `git` manipulations.

## Create a new repository
1. Log into GitHub
2. Press the `+` button at the upper left and select "Import repository".
3. Import from this repository with a new name.

## Configuring the run
1. Clone the repository you created above and `cd` into it.
2. Copy your database backup into `Backups`. If the backup contains database ownership, you'll need to set `DEVELOPMENT_DATABASE_OWNER` in `.env` to the database owner.
3. Copy `env.sample` to `.env` and edit `.env`:
    * Change PROJECT_NAME
    * Change DEVELOPMENT_POSTGRES_NAME
    * Change DEVELOPMENT_DATABASE_OWNER
    * Change STAGING_POSTGRES_NAME
    * Change the passwords and secret keys

## Running the creation
1. Type `bin/create-api-project.sh`. This will build a database image with your backup restored, and an API image. The project scaffolding from the API image will be stored in the repository.
2. When the run completes, examine `db_container.log` to verify that the restore worked.
3. Check your remote - `git remote -v`. Make sure you'll be pushing to the new repository, not the template!
4. `git add .; git commit; git push`.
