# $1: wave file to read
# $2: volume(0-15)
# $3: device for output
#     0: current
#     1: speaker
#    -1: raw speaker(left)
#    -2: raw speaker(right)

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback_audio.sh 2000.wav 15 -1

function enable_speaker
{
	echo "enabling speaker"
	#Default Settings
	tinymix "Stereo2 ADC MIX Switch" 0
	tinymix "Mono ADC MIXR ADC2 Switch" 0
	tinymix "IF2 ADC Mux" "IF_ADC2"
	tinymix "IF3 ADC Mux" "Stereo2_ADC_L/R"
	tinymix "DAC L1 Mux" "IF1 DAC1"
	tinymix "DAC R1 Mux" "IF1 DAC1"
	tinymix "DAC L2 Mux" "Mono ADC MIX"
	tinymix "DAC R2 Mux" "Mono ADC MIX"
	tinymix "DAC1 MIXL DAC1 Switch" 1
	tinymix "DAC1 MIXR DAC1 Switch" 1
	tinymix "DAC L1 Source" "Stereo DAC Mixer"
	tinymix "DAC R1 Source" "Stereo DAC Mixer"
	tinymix "Stereo DAC MIXL DAC L1 Switch" 1
	tinymix "Stereo DAC MIXR DAC R1 Switch" 1
	tinymix "PDM L Mux" "Stereo DAC"
	tinymix "PDM R Mux" "Stereo DAC"
	tinymix "Mono ADC L Mux" "ADC1 L"
	tinymix "Mono ADC R Mux" "ADC1 R"
	tinymix "Mono ADC L1 Mux" "ADC"
	tinymix "Mono ADC R1 Mux" "ADC"
	
	# Music Playback NXP
	tinymix "PDM L Playback Switch" 1
	tinymix "PDM R Playback Switch" 1
	tinymix "Stereo2 ADC MIX Switch" 1
	# off:
	# tinymix "Stereo2 ADC MIX Switch" 0
	tinymix '"STO2 ADC Capture Volume" 18 18'

	climax_hostSW -d /dev/i2c-9 --slave=0x34 -r 4 -w 0x880b -r 9 -w 0x8209 -r 9 -w 0x608
	climax_hostSW -d /dev/i2c-9 --slave=0x37 -r 4 -w 0x880b -r 9 -w 0x8209 -r 9 -w 0x608
}

function disable_speaker
{
	echo "disabling speaker"
	#Default Settings
	tinymix "Stereo2 ADC MIX Switch" 0
	tinymix "Mono ADC MIXR ADC2 Switch" 0
	tinymix "IF2 ADC Mux" "IF_ADC2"
	tinymix "IF3 ADC Mux" "Stereo2_ADC_L/R"
	tinymix "DAC L1 Mux" "IF1 DAC1"
	tinymix "DAC R1 Mux" "IF1 DAC1"
	tinymix "DAC L2 Mux" "Mono ADC MIX"
	tinymix "DAC R2 Mux" "Mono ADC MIX"
	tinymix "DAC1 MIXL DAC1 Switch" 1
	tinymix "DAC1 MIXR DAC1 Switch" 1
	tinymix "DAC L1 Source" "Stereo DAC Mixer"
	tinymix "DAC R1 Source" "Stereo DAC Mixer"
	tinymix "Stereo DAC MIXL DAC L1 Switch" 1
	tinymix "Stereo DAC MIXR DAC R1 Switch" 1
	tinymix "PDM L Mux" "Stereo DAC"
	tinymix "PDM R Mux" "Stereo DAC"
	tinymix "Mono ADC L Mux" "ADC1 L"
	tinymix "Mono ADC R Mux" "ADC1 R"
	tinymix "Mono ADC L1 Mux" "ADC"
	tinymix "Mono ADC R1 Mux" "ADC"
	
	# Music Playback NXP
	tinymix "PDM L Playback Switch" 0
	tinymix "PDM R Playback Switch" 0
	tinymix "Stereo2 ADC MIX Switch" 0
	# off:
	# tinymix "Stereo2 ADC MIX Switch" 0
	tinymix '"STO2 ADC Capture Volume" 18 18'

	climax_hostSW -d /dev/i2c-9 -l /etc/firmware/tfa98xx.cnt  --slave=0x34 PWDN=0
	climax_hostSW -d /dev/i2c-9 -l /etc/firmware/tfa98xx.cnt  --slave=0x37 PWDN=0
}

function enable_left_speaker
{
	echo "enabling left speaker"
	#Default Settings
	tinymix "Stereo2 ADC MIX Switch" 0
	tinymix "Mono ADC MIXR ADC2 Switch" 0
	tinymix "IF2 ADC Mux" "IF_ADC2"
	tinymix "IF3 ADC Mux" "Stereo2_ADC_L/R"
	tinymix "DAC L1 Mux" "IF1 DAC1"
	tinymix "DAC R1 Mux" "IF1 DAC1"
	tinymix "DAC L2 Mux" "Mono ADC MIX"
	tinymix "DAC R2 Mux" "Mono ADC MIX"
	tinymix "DAC1 MIXL DAC1 Switch" 1
	tinymix "DAC1 MIXR DAC1 Switch" 1
	tinymix "DAC L1 Source" "Stereo DAC Mixer"
	tinymix "DAC R1 Source" "Stereo DAC Mixer"
	tinymix "Stereo DAC MIXL DAC L1 Switch" 1
	tinymix "Stereo DAC MIXR DAC R1 Switch" 1
	tinymix "PDM L Mux" "Stereo DAC"
	tinymix "PDM R Mux" "Stereo DAC"
	tinymix "Mono ADC L Mux" "ADC1 L"
	tinymix "Mono ADC R Mux" "ADC1 R"
	tinymix "Mono ADC L1 Mux" "ADC"
	tinymix "Mono ADC R1 Mux" "ADC"
	
	# Music Playback NXP
	tinymix "PDM L Playback Switch" 1
	tinymix "PDM R Playback Switch" 1
	tinymix "Stereo2 ADC MIX Switch" 1
	# off:
	# tinymix "Stereo2 ADC MIX Switch" 0
	tinymix '"STO2 ADC Capture Volume" 18 18'

	climax_hostSW -d /dev/i2c-9 -l /etc/firmware/tfa98xx.cnt  --slave=0x34 PWDN=0
	climax_hostSW -d /dev/i2c-9 -l /etc/firmware/tfa98xx.cnt  --slave=0x37 PWDN=1
	climax_hostSW -d /dev/i2c-9 --slave=0x34 -r 4 -w 0x880b -r 9 -w 0x8209 -r 9 -w 0x608
}

function enable_right_speaker
{
	echo "enabling right speaker"
	#Default Settings
	tinymix "Stereo2 ADC MIX Switch" 0
	tinymix "Mono ADC MIXR ADC2 Switch" 0
	tinymix "IF2 ADC Mux" "IF_ADC2"
	tinymix "IF3 ADC Mux" "Stereo2_ADC_L/R"
	tinymix "DAC L1 Mux" "IF1 DAC1"
	tinymix "DAC R1 Mux" "IF1 DAC1"
	tinymix "DAC L2 Mux" "Mono ADC MIX"
	tinymix "DAC R2 Mux" "Mono ADC MIX"
	tinymix "DAC1 MIXL DAC1 Switch" 1
	tinymix "DAC1 MIXR DAC1 Switch" 1
	tinymix "DAC L1 Source" "Stereo DAC Mixer"
	tinymix "DAC R1 Source" "Stereo DAC Mixer"
	tinymix "Stereo DAC MIXL DAC L1 Switch" 1
	tinymix "Stereo DAC MIXR DAC R1 Switch" 1
	tinymix "PDM L Mux" "Stereo DAC"
	tinymix "PDM R Mux" "Stereo DAC"
	tinymix "Mono ADC L Mux" "ADC1 L"
	tinymix "Mono ADC R Mux" "ADC1 R"
	tinymix "Mono ADC L1 Mux" "ADC"
	tinymix "Mono ADC R1 Mux" "ADC"
	
	# Music Playback NXP
	tinymix "PDM L Playback Switch" 1
	tinymix "PDM R Playback Switch" 1
	tinymix "Stereo2 ADC MIX Switch" 1
	# off:
	# tinymix "Stereo2 ADC MIX Switch" 0
	tinymix '"STO2 ADC Capture Volume" 18 18'

	climax_hostSW -d /dev/i2c-9 -l /etc/firmware/tfa98xx.cnt  --slave=0x34 PWDN=1
	climax_hostSW -d /dev/i2c-9 -l /etc/firmware/tfa98xx.cnt  --slave=0x37 PWDN=0
	climax_hostSW -d /dev/i2c-9 --slave=0x37 -r 4 -w 0x880b -r 9 -w 0x8209 -r 9 -w 0x608
}

echo "Volume is ignored by this script for now"

case $3 in
    1)
        enable_speaker
    ;;
    -1)
        enable_left_speaker
    ;;
    -2)
        enable_right_speaker
    ;;
esac

tinyplay $1
#tinyplay $1 -D 0 -d 0 -p 1024 -n 8

case $3 in
    1|-1|-2)
       disable_speaker
    ;;

esac

exit 0
