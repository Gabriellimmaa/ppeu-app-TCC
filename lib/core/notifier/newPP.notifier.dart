import 'package:flutter/material.dart';
import 'package:ppue/models/PP.model.dart';

class NewPPNotifier extends ChangeNotifier {
  // Responsabilidades voltadas a identificação
  IdentificacaoModel? _identificacao;
  IdentificacaoModel get identificacao => _identificacao!;
  set identificacao(IdentificacaoModel identificacao) {
    _identificacao = identificacao;
    notifyListeners();
  }

  GlobalKey<FormState> _formKeyIdentificacao = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeyIdentificacao => _formKeyIdentificacao;
  set formKeyIdentificacao(GlobalKey<FormState> formKey) {
    _formKeyIdentificacao = formKey;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // Responsabilidades voltadas a avaliação
  AvaliacaoModel? _avaliacao;
  AvaliacaoModel get avaliacao => _avaliacao!;
  set avaliacao(AvaliacaoModel identificacao) {
    _avaliacao = identificacao;
    notifyListeners();
  }

  GlobalKey<FormState> _formKeyAvaliacao = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeyAvaliacao => _formKeyAvaliacao;
  set formKeyAvaliacao(GlobalKey<FormState> formKey) {
    _formKeyAvaliacao = formKey;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // Responsabilidades voltadas a breve historico
  BreveHistoricoModel? _breveHistorico;
  BreveHistoricoModel get breveHistorico => _breveHistorico!;
  set breveHistorico(BreveHistoricoModel identificacao) {
    _breveHistorico = identificacao;
    notifyListeners();
  }

  GlobalKey<FormState> _formKeyBreveHistorico = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeyBreveHistorico => _formKeyBreveHistorico;
  set formKeyBreveHistorico(GlobalKey<FormState> formKey) {
    _formKeyBreveHistorico = formKey;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // Responsabilidades voltadas a recomendacao
  RecomendacoesModel? _recomendacoes;
  RecomendacoesModel get recomendacoes => _recomendacoes!;
  set recomendacoes(RecomendacoesModel identificacao) {
    _recomendacoes = identificacao;
    notifyListeners();
  }

  GlobalKey<FormState> _formKeyRecomendacoes = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeyRecomendacoes => _formKeyRecomendacoes;
  set formKeyRecomendacoes(GlobalKey<FormState> formKey) {
    _formKeyRecomendacoes = formKey;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // Responsabilidades voltadas a situacao
  SituacaoModel? _situacao;
  SituacaoModel get situacao => _situacao!;
  set situacao(SituacaoModel identificacao) {
    _situacao = identificacao;
    notifyListeners();
  }

  GlobalKey<FormState> _formKeySituacao = GlobalKey<FormState>();
  GlobalKey<FormState> get formKeySituacao => _formKeySituacao;
  set formKeySituacao(GlobalKey<FormState> formKey) {
    _formKeySituacao = formKey;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
