from setuptools import setup

setup(
    name="etipme-cli",
    version="1.0.0",
    packages=["etipme", "etipme.commands"],
    include_package_data=True,
    install_requires=["click", "edgar-utils"],
    entry_points="""
        [console_scripts]
        edgarsh=etipme.cli:cli
    """,
)