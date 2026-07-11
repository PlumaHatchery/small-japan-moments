# Growth Loop - Small Japan Moments / Madobe

目的: 記事やページを増やすだけでなく、Madobeへの認知・流入・クリックを増やす。

## 基本ループ

1. ニーズ調査
   - 検索結果、競合ページ、App Store周辺、Japanese aesthetic / iPhone widget / Japanese seasons / 72 microseasons の需要を見る。
   - 怪しい主張や文化説明は避け、暦・季節・アプリ説明は一次情報または確認可能な情報に寄せる。
2. ペルソナ更新
   - 海外の日本文化好き。
   - 日本語学習者・旅行前後の人。
   - iPhoneホーム画面を静かに整えたい人。
   - cozy / aesthetic / seasonal widget を探す人。
3. 流入導線設計
   - 検索: Japanese seasons, 72 microseasons, Japanese aesthetic widgets, calm iPhone widget.
   - 記事: 季節解説 → ホーム画面記事 → Madobeページ。
   - 内部導線: topics / articles / madobe を相互に接続する。
4. 改善
   - 1回に1つ、小さく測れる改善を行う。
   - title / meta description / first view / internal link / CTA / article angle を優先。
5. 公開
   - `main` に commit / push。
   - `./scripts/publish-gh-pages.sh` を実行。
   - `./scripts/check-published.sh` で gh-pages一致を確認。
6. 計測確認
   - PV、検索露出、クリック、Madobeページ遷移を確認する。
   - 計測がない場合は、Search Console / analytics 導入をKaoruに提案する。
7. 報告
   - Kaoruへの報告は原則1日1回。
   - 報告内容: 調査した需要、改善したページ、公開確認、見るべきKPI、次の仮説。

## 当面の優先仮説

- `topics.html` は抽象的すぎるため、検索者の関心別入口とMadobe導線を強化する。
- `Japanese aesthetic widgets` 需要には、派手なテーマ配布ではなく「静かな季節ウィジェット」として差別化する。
- `Japan has more than four seasons` から `72 microseasons`、さらに Madobe へ進む導線を太くする。
