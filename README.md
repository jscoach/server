<p align="center">
  <a href="https://js.coach/">
    <img alt="jess" src="lib/assets/images/jess.svg" width="190" height="190">
  </a>
</p>

<p align="center">
  Welcome to the repository that powers the admin interface and scheduled jobs.
</p>

---

#### Setting up JS.coach

Install the [`foreman`](https://github.com/ddollar/foreman) gem.
Running `foreman start` will start the database for you and the rails server.
You can run processes individually using `foreman start web` and `foreman start postgresql`.

Credentials and other sensitive information are stored in the `.env` file.
Duplicate the existing `.env.example` file and fill the variables.
To load these variables when you run rails commands, prefix them with `foreman run`.
For example, to start the rails console type the following command:

```shell
foreman run rails c
```

#### Found a bug or have feedback?

Please open an issue in the [support repository](https://github.com/jscoach/support).
Feel free to submit PRs here.

#### Looking for the old source?

Check out the [classic branch](https://github.com/jscoach/support/tree/classic/project).
