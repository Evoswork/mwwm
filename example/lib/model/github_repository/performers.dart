import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/github_repository/changes.dart';
import 'package:mwwm_github_client/model/github_repository/repository/github_repository.dart';

class SearchRepositoriesPerformer
    extends FuturePerformer<List<Repository>, SearchRepositories> {
  final GithubRepository _githubRepository;

  SearchRepositoriesPerformer(this._githubRepository);

  @override
  Future<List<Repository>> perform(SearchRepositories change) {
    return _githubRepository.findRepositories(change.query);
  }
}

class GetRepositoriesPerformer
    extends FuturePerformer<List<Repository>, GetRepositories> {
  final GithubRepository _githubRepository;

  GetRepositoriesPerformer(this._githubRepository);

  @override
  Future<List<Repository>> perform(GetRepositories change) {
    return _githubRepository.getRepositories();
  }
}