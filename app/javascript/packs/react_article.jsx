import React from 'react'
import ReactDOM from 'react-dom'
// import PropTypes from "prop-types"
import {
    BrowserRouter as Router,
    Switch,
    Route,
    Link
} from "react-router-dom";

function IndexArticle(props) {
    return (
        <div className="elements">
            <h2 className="contents">
                <a onClick={ () => props.ToShow(props.article.id)} className="ToShow">
                    {props.article.title}
                </a>
            </h2>
            <p className="contents">
                {props.article.abstract}
            </p>
        </div>
    );
}

function IndexArticles(props) {
    const articles = props.articles.map(article => {
        return (
            <IndexArticle
                article={article}
                key={article.id}
                ToShow={props.ToShow}
            />
        );
    });
    return (
        <div>
            {articles}
        </div>
    );
}

function EachArticle(props) {
    const article = props.article
    const download_path = "/articles/" + article.id + "/download"
    return (
        <div>
            <h2 className="contents">
               {article.title}
            </h2>
            <div className="floating">
                <h4 className="content-start">
                    {article.author}
                </h4>
                <h4 className="content">
                    {article.year}
                </h4>
                <h4 className="content-end">
                    {article.degree}
                </h4>
            </div>
            <p className="abstract">{article.abstract}</p>
            <h4>
                <a href={download_path} className="contents">PDFダウンロード</a>
            </h4>
            <h4>
                <a onClick={ () => props.ToIndex()} className="react_contents">記事一覧</a>
            </h4>            
        </div>
    );
}

function WhichArticle(props) {
    const articles = props.articles.map(article => {
        if (props.id === article.id) {
            return (
                <EachArticle
                    article={article}
                    key={article.id}
                    ToIndex={props.ToIndex}
                />
            );
        }
    });
    return (
        <div>
            {articles}
        </div>
    );
}

function SearchArticlePage() {
    return (
        <div>
            {/* <div class="page-title">
                <h2>論文検索</h2>
            </div>
            <div class="search">
                <%= form_with(url: search_path, method: :get) do |f|  %>
                    <p><%= f.label :"学位" %></p>
                    <p><%= f.select :degree, [[""], ["学士"], ["修士"], ["博士"]], {}, class: 'form-control' %></p>
                    <p><%= f.label :"キーワード" %></p>
                    <p><%= f.text_field :keyword, class: 'form-control' %></p>
                    <p><%= f.label :"年度" %></p>
                    <p><%= f.text_field :year, class: 'form-control' %></p>    
                    <p class="search-button"><%= f.submit 'search', class: "btn btn-block btn-primary" %></p>
                <% end %>
            </div> */}
        </div>
    );
}

function SearchArticle(props) {
    const articles = props.articles.map(article => {
        return (
            <ShowSearchResult
                article={article}
            />
        );
    });
    return (
        <div>
            {articles}
        </div>
    );
}

function ShowSearchResult(props) {
    const article = props.article
    return (
        <div>
            <div class="page-title">
                <h2>検索結果</h2>
            </div>
            <div class="elements">
                <h2 class="contents">
                    <a>article.title</a>
                </h2>
                <p class="contents">article.abstract</p>
            </div>
        </div>
    );
}

class Main extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            error: null,
            action: "react_index",
            articles: [],
            id: null
        };
        this.ToShow = this.ToShow.bind(this);
        this.ToIndex = this.ToIndex.bind(this);
    }

    componentDidMount() {
        console.log(this.props.url)
        fetch("http://192.168.33.10:3000/react_test")
        // fetch(this.props.url)
            .then(res => res.json())
            .then(
                (result) => {
                    this.setState({
                        articles: result.articles
                    });
                },
                (error) => {
                    this.setState({
                        error
                    });
                }
            )
    }

    ToShow(id) {
        this.setState({
            action: "react_show",
            id: id
        });
    }

    ToIndex() {
        this.setState({
            action: "react_index"
        });
    }

    render() {
        const action = this.state.action;
        let Article = null;
        switch(action) {
            case "react_index":
                Article = (() =>
                    <IndexArticles
                        articles={this.state.articles}
                        WhichId={this.WhichId}
                        ToShow={this.ToShow}
                    />
                );
                break;
            case "react_show":
                Article = (() =>
                    <WhichArticle
                        articles={this.state.articles}
                        id={this.state.id}
                        ToIndex={this.ToIndex}
                    />
                );
                break;
            case "react_search":
            Article = (() => 
                <SearchArticle
                    keyword={this.state.keyword}
                    degree={this.state.degree}
                    year={this.state.year}
                />
            );
        }
        return (
            <div>
                <Article/>
            </div>
        );
    }
}

ReactDOM.render(
    <Main/>,
    document.getElementById('react_article'),
);