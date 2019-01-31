FROM python:3.6

# prepare a build environment
RUN apt-get update
RUN apt-get install -y --no-install-recommends\
 git bash gcc g++ gfortran libblas-dev liblapack-dev libpng-dev libffi-dev libfreetype6 libjpeg-dev libhdf5-dev

WORKDIR /root
# if we don't build numpy first scipy complains
RUN pip install numpy
RUN git clone https://github.com/openai/gym && cd gym && pip install .
RUN git clone https://github.com/jvmancuso/ai-safety-gridworlds && cd ai-safety-gridworlds && pip install .
RUN git clone https://github.com/david-lindner/safe-grid-gym && cd safe-grid-gym && pip install .
RUN pip install tensorflow tensorboard torch

COPY setup.py README.md run.sh main.py /root/
COPY safe_grid_agents /root/safe_grid_agents
RUN pip install .

EXPOSE 6006

ENTRYPOINT ["/bin/bash", "run.sh"]
CMD ["-dc", "-E", "1000", "-V", "100", "-EE", "50", "corners",  "ppo-cnn", "-l", ".2", "-r", "32", "-e", "2", "-cc", ".2", "-eb", ".1"]
