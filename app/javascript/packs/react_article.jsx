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
        <div>
            <h2 className="contents">
                <a onClick={ () => props.ToShow(props.article.id)}>
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
        <div className="elements">
            {articles}
            <a onClick={ () => props.ToShow(props.article.id)}>
                To Show
            </a>
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
                />
            );
        }
    });
    return (
        <div>
            {articles}
            <a onClick={ () => props.ToIndex()}>
                To Index
            </a>
        </div>
    );
}

function EachArticle(props) {
    const article = props.article
    console.log(article)    
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
                <a href="download_path(@article.id)" className="contents">PDFダウンロード</a>
            </h4>
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
        // console.log(this.props.url)
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
                        id={}
                        ToIndex={this.ToIndex}
                    />
                );
                break;
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