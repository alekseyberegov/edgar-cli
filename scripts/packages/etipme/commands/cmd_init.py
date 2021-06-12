from etipme.cli import pass_environment

import click, configparser
from pathlib import Path

@click.command("init", short_help="Initializes a repository")
@click.argument("path", required=False, type=click.Path(resolve_path=True))
@pass_environment
def cli(ctx, path):
    """Initializes a repository."""
    repo = init_repo()
    if path is None:
        dir = repo / 'data'
        dir.mkdir(exist_ok=True)
        path = str(dir)

    update_metadata(repo, {
        'root': path, 
        'quarterly_file': 'master.idx',
        'daily_file': 'master{y}{m:02}{d:02}.idx',
        'object_path': "['{t}', '{y}', 'QTR{q}']"
    })
    ctx.log(f"Initialized the repository in {click.format_filename(path)}")
  
def init_repo():
    repo = Path.home() / '.etipme' / 'repo'
    repo.mkdir(exist_ok=True)
    return repo

def update_metadata(repo: Path, meta) -> None:
    config = configparser.ConfigParser()
    config['DATA'] = meta
    with open(repo / 'repo.ini', 'w') as file:
        config.write(file)

