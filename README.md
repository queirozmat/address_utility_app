A proposta do projeto é permitir que o usuário localize seu endereço através do Logradouro, cidade e UF. Após obter uma lista de endereços correspondentes, o usuário pode refinar sua busca adicionando filtros como o bairro e a UF. Uma vez encontrado o endereço desejado, ele tem a opção de adicioná-lo à sua lista de "Meus endereços", onde poderá visualizar facilmente seus endereços salvos.

Para desenvolver este projeto, foi adotada uma arquitetura baseada em MVC, com o gerenciamento de estado sendo realizado através do MobX. O aplicativo foi projetado para ser responsivo em diferentes plataformas, incluindo WEB, Android e IOS, utilizando pacotes compatíveis com cada uma delas.

O aplicativo consiste basicamente em duas páginas: "Meus endereços", onde o usuário pode visualizar os endereços salvos, e "Procurar endereços", onde é possível realizar buscas por endereços. Para evitar repetições no código, foram componentizados widgets como o "CardMyAddress", responsável pela exibição dos endereços na lista, e o "MyDrawer", que representa o menu lateral do aplicativo.
