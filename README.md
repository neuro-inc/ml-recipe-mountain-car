# Deep Q-Learning (DQN) 

The first deep learning model to successfully learn control policies
directly from high-dimensional sensory input using
reinforcement learning was presented by [Mnih et. al.](https://www.cs.toronto.edu/~vmnih/docs/dqn.pdf)

The model was a convolutional neural network, trained with a variant of Q-learning,
whose input is raw pixels and whose output was a value function estimating future
rewards.

![car](https://user-images.githubusercontent.com/1387585/70574334-c090ab80-1b58-11ea-988d-f40afb6642a2.jpg)

We will apply the approach discovered in that paper to one of the traditional
[OpenAi gym](https://gym.openai.com/) environments [Mountain Car](https://gym.openai.com/envs/MountainCar-v0/).

Classic DQN presents a rather simplistic approach, but at the same time
 an excellent starting point to dive into Deep Reinforcement Learning with 
the help of this recipe.  

# Quick Start

##### 0. Sign up at [neu.ro](https://neu.ro)

##### 1. Install CLI and log in
```shell
pip install -U neuromation
neuro login
```

##### 2. Run the recipe

```shell
git clone git@github.com:neuromation/ml-recipe-hier-attention.git
cd ml-recipe-mountain-car
make setup
make jupyter
```

# Description

This project is created from 
[Neuro Platform Project Template](https://github.com/neuromation/cookiecutter-neuro-project).

# Development Environment

This project is designed to run on [Neuro Platform](https://neu.ro), so you can jump into problem-solving right away.

## Directory structure

| Local directory                      | Description       | Storage URI                                    | Environment mounting point           |
|:------------------------------------ |:----------------- |:-----------------------------------------------|:-------------------------------------| 
| `data/`                              | Data              | `storage:ml-recipe-mountain-car/data/`         | `/ml-recipe-mountain-car/data/`      | 
| `modules/`                           | Python modules    | `storage:ml-recipe-mountain-car/modules/`      | `/ml-recipe-mountain-car/modules/`   |
| `notebooks/`                         | Jupyter notebooks | `storage:ml-recipe-mountain-car/notebooks/`    | `/ml-recipe-mountain-car/notebooks/` |
| No directory                         | Logs and results  | `storage:ml-recipe-mountain-car/results/`      | `/ml-recipe-mountain-car/results/`   |

## Development

Follow the instructions below to set up the environment and start Jupyter development session.

### Setup development environment 

`make setup`

* Several files from the local project are uploaded to the platform storage (namely, `requirements.txt`, 
  `apt.txt`, `setup.cfg`).
* A new job is started in our [base environment](https://hub.docker.com/r/neuromation/base). 
* Pip requirements from `requirements.txt` and apt applications from `apt.txt` are installed in this environment.
* The updated environment is saved under a new project-dependent name and is used further on.

### Run Jupyter with GPU 

`make jupyter`

* The content of `modules` and `notebooks` directories is uploaded to the platform storage.
* A job with Jupyter is started, and its web interface is opened in the local web browser window.

### Kill Jupyter

`make kill-jupyter`

* The job with Jupyter Notebooks is terminated. The notebooks are saved on the platform storage. You may run 
  `make download-notebooks` to download them to the local `notebooks/` directory.

### Help

`make help`

## Data

### Uploading via Web UI

On local machine run `make filebrowser` and open job's URL on your mobile device or desktop.
Through a simple file explorer interface, you can upload test images and perform file operations.

### Uploading via CLI

On local machine run `make upload-data`. This command pushes local files stored in `./data`
into `storage:ml-recipe-mountain-car/data` mounted to your development environment's `/project/data`.

## Customization

Several variables in `Makefile` are intended to be modified according to the project specifics. 
To change them, find the corresponding line in `Makefile` and update.

### Data location

`DATA_DIR_STORAGE?=$(PROJECT_PATH_STORAGE)/$(DATA_DIR)`

This project template implies that your data is stored alongside the project. If this is the case, you don't 
have to change this variable. However, if your data is shared between several projects on the platform, 
you need to change the following line to point to its location. For example:

`DATA_DIR_STORAGE?=storage:datasets/cifar10`

### Training machine type

`TRAINING_MACHINE_TYPE?=gpu-small`

There are several machine types supported on the platform. Run `neuro config show` to see the list.

### HTTP authentication

`HTTP_AUTH?=--http-auth`

When jobs with HTTP interface are executed (for example, with Jupyter Notebooks or TensorBoard), this interface requires
a user to be authenticated on the platform. However, if you want to share the link with someone who is not registered on
the platform, you may disable the authentication updating this line to `HTTP_AUTH?=--no-http-auth`.

### Training command

`TRAINING_COMMAND?='echo "Replace this placeholder with a training script execution"'`

If you want to train some models from code instead of Jupyter Notebooks, you need to update this line. For example:

`TRAINING_COMMAND="bash -c 'cd $(PROJECT_PATH_ENV) && python -u $(CODE_DIR)/train.py --data $(DATA_DIR)'"`

