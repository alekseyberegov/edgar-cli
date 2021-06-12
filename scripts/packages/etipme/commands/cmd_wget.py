from urllib.parse import urlparse, ParseResult
from etipme.cli import pass_environment
from edgar.utils.repo.http_client import HttpClient

import click

@click.command("wget", short_help="Get a remote file")
@click.argument("url", required=True)
@pass_environment
def cli(ctx, url):
    parsed: ParseResult = urlparse(url)
    client: HttpClient = HttpClient(parsed._replace(path="/").geturl())  
    
    code: int = client.get(parsed.path)
    if code != 200:
        ctx.log(f"The response code is {code}")
    else:
        for i in client.inp():
            ctx.log(i)

    client.close()