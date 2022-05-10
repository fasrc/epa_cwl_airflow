from setuptools import setup, find_packages

with open("README.md", "r") as readme:
    long_description = readme.read()

setup(
    name='fasrc_sample_tools',
    version="0.0.1",
    url='https://github.com/fasrc/epa_cwl_workflow',
    license='',
    author='FAS RC Research Computing',
    author_email='mbouzinier@g.harvard.edu',
    description='Sample CWL Workflow',
    long_description=long_description,
    long_description_content_type="text/markdown",
    package_dir={
        "fasrc_sample_tools": "./src/fasrc_sample_tools"
    },
    install_requires=[
        "fiona",
        "geopandas",
        "pandas",
        "pygeos",
        "shapely"
    ],
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: Harvard University :: Development",
        "Operating System :: OS Independent",
    ]
)
