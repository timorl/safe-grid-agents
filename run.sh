BASE_DIRECTORY=`dirname "${BASH_SOURCE[0]}"`
LOGDIR=$BASE_DIRECTORY/`hostname`-`date +%F_%H%M`
python $BASE_DIRECTORY/main.py --log-dir $LOGDIR $@ &
tensorboard --logdir $LOGDIR
