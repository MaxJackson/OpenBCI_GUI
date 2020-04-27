import brainflow.*;

class BoardBrainFlowSynthetic extends BoardBrainFlow
implements AccelerometerCapableBoard, PPGCapableBoard, EDACapableBoard {

    private int[] accelChannels = {};
    private int[] edaChannels = {};
    private int[] ppgChannels = {};

    @Override
    public boolean initializeInternal() {
        boolean res = super.initializeInternal();

        try {
            accelChannels = BoardShim.get_accel_channels(getBoardIdInt());
            edaChannels = BoardShim.get_eda_channels(getBoardIdInt());
            ppgChannels = BoardShim.get_ppg_channels(getBoardIdInt());

        } catch (BrainFlowError e) {
            e.printStackTrace();
            res = false;
        }

        return res;
    }

    // implement mandatory abstract functions
    @Override
    protected BrainFlowInputParams getParams() {
        BrainFlowInputParams params = new BrainFlowInputParams();
        return params;
    }

    @Override
    public BoardIds getBoardId() {
        return BoardIds.SYNTHETIC_BOARD;
    }

    @Override
    public void setEXGChannelActive(int channelIndex, boolean active) {
        // Dummy string
        configBoard("SYNTHETIC PLACEHOLDER");
    }

    @Override
    public boolean isEXGChannelActive(int channelIndex) {
        return true;
    }

    @Override
    public boolean isAccelerometerActive() {
        return true;
    }

    @Override
    public void setAccelerometerActive(boolean active) {
        outputWarn("Accelerometer is always active for BrainflowSyntheticBoard");
    }

    @Override
    public int[] getAccelerometerChannels() {
        return accelChannels;
    }

    @Override
    public boolean isPPGActive() {
        return true;
    }

    @Override
    public void setPPGActive(boolean active) {
        outputWarn("PPG is always active for BrainflowSyntheticBoard");
    }

    @Override
    public int[] getPPGChannels() {
        return ppgChannels;
    }

    @Override
    public boolean isEDAActive() {
        return true;
    }

    @Override
    public void setEDAActive(boolean active) {
        outputWarn("EDA is always active for BrainflowSyntheticBoard");
    }

    @Override
    public int[] getEDAChannels() {
        return edaChannels;
    }
    
    @Override
    protected void addChannelNamesInternal(String[] channelNames) {
        for (int i=0; i<edaChannels.length; i++) {
            channelNames[edaChannels[i]] = "EDA Channel " + i;
        }
        for (int i=0; i<ppgChannels.length; i++) {
            channelNames[ppgChannels[i]] = "PPG Channel " + i;
        }
        for (int i=0; i<accelChannels.length; i++) {
            channelNames[accelChannels[i]] = "Accel Channel " + i;
        }
    }
};
