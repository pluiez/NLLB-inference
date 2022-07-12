set -euo pipefail

root=$(dirname $0)

usage () {
    echo "usage: $0 ckp slang tlang < input > output" >&2
    exit 1
}

[ $# -eq 3 ] || usage

ckp=$1
slang=$2
tlang=$3

translate () {
    local ckp slang tlang
    ckp=$1
    slang=$2
    tlang=$3
    bash $root/preprocess/normalize_punctuation.sh $slang < /dev/stdin | \
        spm_encode --model $root/preprocess/flores200_sacrebleu_tokenizer_spm.model | \
        fairseq-interactive $root --input - -s $slang -t $tlang \
            --path $ckp --batch-size 1024 --max-tokens 8192 --buffer-size 100000 \
            --beam 4 --lenpen 1.0 \
            --fp16 \
            --fixed-dictionary $root/dictionary.txt \
            --task translation_multi_simple_epoch \
            --decoder-langtok --encoder-langtok src \
            --langs $(cat $root/langs.txt) \
            --lang-pairs $slang-$tlang \
            --add-data-source-prefix-tags 2>&1
}

translate $ckp $slang $tlang < /dev/stdin
