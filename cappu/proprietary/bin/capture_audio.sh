# $1: wave file to write
# $2: audio source
#     0: default
#     1: mic
#    -1: raw main mic
#    -2: raw top mic
# $3: sample rate(Hz)
# $4: sample bit
# $5: channel number
# $6: capture duration(s)
# tinycap file.wav [-D card] [-d device] [-c channels] [-r rate] [-b bits] [-p period_size] [-n n_periods] [-t duration]
# sample usage: capture_audio.sh /data/test1.wav -1 48000 16 1 10

echo "sample bit is ignored in this script for now"

function enable_main_mic
{
	echo "enabling main mic"
	#Default Settings
	tinymix 'IN3 Boost Volume' 40
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

	#Record Main Mic
	tinymix "RECMIX1L BST3 Switch" 1
	tinymix "RECMIX1R BST3 Switch" 1

	#Record Headset Mic
	tinymix "RECMIX1L BST1 Switch" 0
	tinymix "RECMIX1R BST1 Switch" 0

	tinymix "Mono ADC MIXL ADC1 Switch" 1
	tinymix "Mono ADC MIXR ADC1 Switch" 1

	#tinymix -D 0 'IN4 Boost Volume' 64
	#tinymix -D 0 'STO1 ADC Capture Volume' 50 50
	#tinymix -D 0 'STO1 ADC Capture Switch' 0 0
}

function disable_main_mic
{
	echo "enabling main mic"
	#Default Settings
	tinymix 'IN3 Boost Volume' 40
	tinymix "Stereo2 ADC MIX Switch" 0
	tinymix "Mono ADC MIXR ADC2 Switch" 0
	tinymix "IF2 ADC Mux" "IF_ADC2"
	tinymix "IF3 ADC Mux" "Stereo2_ADC_L/R"
	tinymix "DAC L1 Mux" "IF1 DAC1"
	tinymix "DAC R1 Mux" "IF1 DAC1"
	tinymix "DAC L2 Mux" "Mono ADC MIX"
	tinymix "DAC R2 Mux" "Mono ADC MIX"
	tinymix "DAC1 MIXL DAC1 Switch" 0
	tinymix "DAC1 MIXR DAC1 Switch" 0
	tinymix "DAC L1 Source" "Stereo DAC Mixer"
	tinymix "DAC R1 Source" "Stereo DAC Mixer"
	tinymix "Stereo DAC MIXL DAC L1 Switch" 0
	tinymix "Stereo DAC MIXR DAC R1 Switch" 0
	tinymix "PDM L Mux" "Stereo DAC"
	tinymix "PDM R Mux" "Stereo DAC"
	tinymix "Mono ADC L Mux" "ADC1 L"
	tinymix "Mono ADC R Mux" "ADC1 R"
	tinymix "Mono ADC L1 Mux" "ADC"
	tinymix "Mono ADC R1 Mux" "ADC"

	#Record Main Mic
	tinymix "RECMIX1L BST3 Switch" 0
	tinymix "RECMIX1R BST3 Switch" 0

	#Record Headset Mic
	tinymix "RECMIX1L BST1 Switch" 0
	tinymix "RECMIX1R BST1 Switch" 0

	tinymix "Mono ADC MIXL ADC1 Switch" 1
	tinymix "Mono ADC MIXR ADC1 Switch" 1

	#tinymix -D 0 'IN3 Boost Volume' 64
	#tinymix -D 0 'IN4 Boost Volume' 64
	#tinymix -D 0 'STO1 ADC Capture Volume' 50 50
	#tinymix -D 0 'STO1 ADC Capture Switch' 0 0
}

function enable_top_mic
{
	echo "PHONE HAS NO TOP MIC!"
}

function disable_top_mic
{
	echo "PHONE HAS NO TOP MIC!"
}

function enable_back_mic
{
	echo "PHONE HAS NO BACK MIC!"
}

function disable_back_mic
{
	echo "PHONE HAS NO BACK MIC!"
}

function enable_front_mic
{
	echo "PHONE HAS NO FRONT MIC!"
}

function disable_front_mic
{
	echo "PHONE HAS NO FRONT MIC!"
}

# setup
#

case "$2" in
	"-1" )
		enable_main_mic
		;;
	"-2" )
		enable_top_mic
		;;
esac

# start recording
#tinycap $1 -c $5 -r $3 -b $4 -t $6
echo tinycap $1 -D 0 -d 1 -c $5 -r $3 -b $4 -p 1024 -n 8 -t $6
tinycap $1 -D 0 -d 1 -c $5 -r $3 -b $4 -p 1024 -n 8 -t $6

ret=$?
if [ $ret -ne 0 ]; then
	echo "tinycap done, return $ret"
fi

# tear down
case "$2" in
	"-1" )
		disable_main_mic
		;;
	"-2" )
		disable_top_mic
		;;
esac
