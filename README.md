# BersShannonRabbit-Negroni2015-Mohammed2021Gel
Bers-Shannon Rabbit electrophysiology model combined with Negroni2015 (the model also includes rabbit electrophysiology, but here only TRPNs and X are picked and added to Bers-Shannon original model)

For mechanical equilibrium the cell passive stiffness is based on Lin-Yin and serial-connected to Mohammed2021Gel<br>

At each timestep of ode excitation-contraction coupling model, to obtain L for negroni model, mechanical loop called and solved with nonlinear iteration. 

##Reference:
- Thomas R. Shannon, Fei Wang, Jose Puglisi, Christopher Weber, Donald M. Bers
  "A Mathematical Treatment of Integrated Ca Dynamics Within the Ventricular Myocyte",
  Biophys J., 87:3351-3371 (2004).

- Jorge A. Negroni et al.
  "β-adrenergic effects on cardiac myofilaments and contraction in an integrated rabbit ventricular myocyte model"
  J Mol Cell Cardiol. 2015

- Mohammad et al. 
  “A viscoelastic Eshelby inclusion model and analysis of the Cell-in-Gel system” 
  Int. J. Eng. Sci. Vol. 165, 103489, (2021)

## How to run
rabbit_negroni2015_Gel_everystep.m is the main function; execute this code.
If you want to run with original Negroni model with isometric or loadfree boundary conditions, comment-out the IsometHyperGel function and de-commentout the corresponding code 

## What is this code for?
To examine the afterload effect on the negroni model.

## Developers memo
ODE15sが自動で時間積分を実施してくれるのは便利なのだが、dtが可変なうえに、失敗すると戻って計算したりすることが分かった。（ここでとてもトラブって時間がかかった）
Negroniモデル自身は、静的なつり合い問題を各タイムステップで解いているので特に問題が起こらないのだが、Gelは履歴依存なので、前ステップの情報を利用する。
1ステップ戻るだけでなく、もう少し前から解きなおしたりすることがあるようなので、istepとその時の時刻を保存するtarray、その時のGelの履歴情報保管用Qkarrayを作って、
Electrophysiology側が今求めたい時刻tと、最新情報をistep番目に保存してある履歴tarrayとを確認して必要な過去情報を使うようにした。

udot0は本当は前回のudot情報を使うと良いはずなのだが、Electrophysiologyに合わせている都合上、
dtが非常に小さいことがある→udotがめちゃくちゃ大きい時がある→次のタイムステップでdtが大きいとuの初期値が飛ぶ、
という現象のため、むしろ初期値0から探した方が変な解に飛ばず安定に解けることが分かった。だから引数に入っているけど結局0で初期化している。傾きも適切に入れることが重要。
Negroniモデルの特性上、X_wとかがすごく長いところにも平衡点があるようで、初期値や傾きを誤ると、変な振動解が得られる。

Ele先生のGithubにNegroni2015のMatlabコードがあったから、最初からそれとゲルをくっつければよかった。。
