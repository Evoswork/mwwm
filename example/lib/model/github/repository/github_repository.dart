import 'dart:convert';

import 'package:mwwm_github_client/data/owner.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/data/repository_list.dart';
import 'package:mwwm_github_client/model/common/network/network_client.dart';
import 'package:mwwm_github_client/model/github/repository/dto/owner_dto.dart';
import 'package:mwwm_github_client/model/github/repository/dto/repository_dto.dart';
import 'package:mwwm_github_client/model/github/repository/dto/repository_list_dto.dart';
import 'package:http/http.dart' show Response;

/// Service for work with Github
/// Wrapper on [Github] library
class GithubRepository {
  GithubRepository(
    this._client,
  );

  final NetworkClient _client;

  /// Search repository by [name]
  Future<List<Repository>> findRepositories(String name) async {
    if (name.isEmpty) return [];

    final Response response = await _client.get(
      'https://api.github.com/search/repositories?q=$name',
    );
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final RepositoryList repositoryList = RepositoryListDto.fromJson(json).data;

    return repositoryList.items;
  }

  /// Get github repositories
  Future<List<Repository>> getRepositories() async {
    final Response response = await _client.get(
      'https://api.github.com/repositories',
    );
    final json = jsonDecode(response.body) as List<dynamic>;
    final List<Repository> repositories = json
        .map<Repository>(
          (json) => RepositoryDto.fromJson(json as Map<String, dynamic>).data,
        )
        .toList();

    return repositories;
  }

  /// Get Github-users
  Future<List<Owner>> getUsers() async {
    final Response response = await _client.get('https://api.github.com/users');
    final json = jsonDecode(response.body) as List<dynamic>;
    final List<Owner> users = json
        .map<Owner>(
          (json) => OwnerDto.fromJson(json as Map<String, dynamic>).data,
        )
        .toList();

    return users;
  }
}
