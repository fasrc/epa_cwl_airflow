from setuptools import setup, find_packages

with open("README.md", "r") as readme:
    long_description = readme.read()

setup(
    name='epa_cwl_workflow',
    version="0.0.1",
    url='https://github.com/fasrc/epa_cwl_workflow',
    license='',
    author='FAS RC Research Computing',
    author_email='mbouzinier@g.harvard.edu',
    description='Sample CWL Workflow',
    long_description=long_description,
    long_description_content_type="text/markdown",
    packages=find_packages(),
    install_requires=[
        "cwltool",
        "cwlref-runner"
    ],
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: Harvard University :: Development",
        "Operating System :: OS Independent",
    ]
)
