# NLLB-inference

A convenient script for running [NLLB](https://github.com/facebookresearch/fairseq/tree/nllb/examples/nllb/modeling) generation/inference without tangling with the config files. 

## Usage

The following is an example translation from Chinese to English using Distilled-600M checkpoint:
```bash
$ bash translate.sh /path/to/checkpoints/checkpoint.NLLB-200-Distilled-600M.pt zho_Hans eng_Latn <<< '感谢Facebook开源大规模多语言翻译模型'
S-0     __zho_Hans__ ▁ 感谢 Facebook 开 源 大 规模 多 语言 翻 译 模型
W-0     0.729   seconds
H-0     -0.6472707390785217     ▁Thanks ▁to ▁Facebook ' s ▁large - s cale ▁open ▁source ▁mul til ingu al ▁translation ▁model
D-0     -0.6472707390785217     ▁Thanks ▁to ▁Facebook ' s ▁large - s cale ▁open ▁source ▁mul til ingu al ▁translation ▁model
P-0     -0.4494 -1.2429 -0.2038 -1.0701 -0.7286 -0.1321 -1.9717 -0.9398 -0.1507 -0.0841 -1.8209 -1.1124 -0.6446 -0.0513 -0.0773 -0.1323 -0.5544 -0.3851 -0.5465
```
