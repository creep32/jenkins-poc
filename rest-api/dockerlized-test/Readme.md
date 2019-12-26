# dokcer-compose 利用パターン
* ローカル環境での開発効率を最大化
* ローカル環境でのテスト機構を、CIでもそのまま使えるように
* docker-composeに集約し、教育コストを最小化

## メモ
* CI環境で複数のdocer-composeプロジェクトが動く可能性があるため、コンテナ、ネットワーク名がユニークになる必要がある
  * local実行時はportをpublishedにしたいが、ci環境ではしたくないため、YAMLを複数にわけ、ローカル実行時にはport publishするoverrideを指定するようにしている（いろいろ試したがこれでしか実現できなかった)
  * `-p, --project-name NAME` オプションをつけると、ネットワーク、ボリュームなどに自動でprefixがつき競合がおきない（この値に、JenkinsのBUILD_IDなどを渡す)
  * `docker-compose run` の場合、`--project-name` オプションがなぜかきかいないので、[COMPOSE_PORJECT_NAME](https://docs.docker.com/compose/reference/envvars/) を直接渡している
  * `container_name`には自動でprefixがつかなかったので、自前でつけるようにしている

# kubernets 利用パターン
