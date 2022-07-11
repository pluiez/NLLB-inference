# NLLB-inference

A convenient script for running [NLLB](https://github.com/facebookresearch/fairseq/tree/nllb/examples/nllb/modeling) generation/inference without tangling with the config files. 

## Usage

Get the [NLLB checkpoint](https://github.com/facebookresearch/fairseq/tree/nllb/examples/nllb/modeling#open-sourced-models-and-metrics) and then find the code mapping for your languages from [Languages in FLORES-200](https://github.com/facebookresearch/flores/tree/main/flores200#languages-in-flores-200).

*NOTE*: the following script only deals with dense model with params ranged from 600M to 3.3B, and inference with MoE requires extra arguments. The file size of the MoE model is 337G, actually most people don't have the resources to get such a large model running at least in a short term.

### Prerequisites

1. clone or update the [fairseq](https://github.com/facebookresearch/fairseq) repo, then switch to NLLB branch.
2. install [sentencepiece](https://github.com/google/sentencepiece) for command line usage.

### Pre-Processing and Inference

The following is an example translation from Chinese to English using Distilled-600M checkpoint:

```bash
$ bash translate.sh /path/to/checkpoints/checkpoint.NLLB-200-Distilled-600M.pt zho_Hans eng_Latn <<< '感谢Facebook为大规模多语言机器翻译做出的开源贡献'
S-0     __zho_Hans__ ▁ 感谢 Facebook 为 大 规模 多 语言 机 器 翻 译 做 出的 开 源 贡献
W-0     1.238   seconds
H-0     -0.5970411896705627     ▁Thanks ▁to ▁Facebook ▁for ▁its ▁open - so urce ▁contribution ▁to ▁large - s cale ▁mul til ingu al ▁machine ▁translation
D-0     -0.5970411896705627     ▁Thanks ▁to ▁Facebook ▁for ▁its ▁open - so urce ▁contribution ▁to ▁large - s cale ▁mul til ingu al ▁machine ▁translation
P-0     -0.1890 -1.8898 -0.2183 -0.3387 -0.5034 -1.0127 -1.3067 -1.7645 -0.1620 -0.0765 -0.7432 -0.3358 -2.9018 -0.4164 -0.1267 -0.0749 -0.4482 -0.0686 -0.0824 -0.1171 -0.1867 -0.3008 -0.4675
```
### Post-Processing

The postprocessing script is not included here, you can follow the 2 steps below to postprocess the output:
1. `spm_decode`.
2. `sed 's/^<MINED_DATA> //g'` to remove the potential dataset tag token.
