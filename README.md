# CLI to manage EDGAR financial reporting

## Getting HELP
1. Show available commands
    ```
    $ ./etipme.sh --help
    ```

## First use
1. Install python venv
   ```
   $ ./etipme.sh package init
   ```
2. Install local version of `edgar-utils` (dev mode only)
   ```
   $ ./etipme.sh package local <path to edgar-utils>
   ```
3. Initialize EDGAR shell
   ```
   $ ./etipme.sh shell
   ```

## Configuring CLI
Edit `$ETIPME_HOME/config/edgar.env`

| Parameter         | Default                        | Description               |
| ----------------- | -------------------------------| ------------------------- |
| user_agent        | Chrome 90                      | user agent for downloads  |
| edgar_archive_url | <https://www.sec.gov/Archives> | EDGAR archive URL         |
| etipme_cache_dir  | `~/.etipme/cache`              | cache directory           |
| etipme_pyenv_dir  | `~/.etipme/venv`               | python venv directory     |
| default_sort      | `master`                       | the default index sorting |
| default_index     | `daily`                        | the default archive type  |
| default_workday   | `20210401`                     | the default index date    |

## The directory structure of `~/.etipme`
| Directory                       |  Description                                 |
| ------------------------------- | -------------------------------------------- |
| `~/etipme/venev`                | Python virtual environment                   |
| `~/etipme/repo`                 | EDGAR local archive                          |
| `~/etipme/cache`                | Cache directory                              |

