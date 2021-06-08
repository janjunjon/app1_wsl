import React from 'react'
import ReactDOM from 'react-dom'

const article = {id: 1, title: 'research0', author: 'jjthomson', year: 2020, degree: "bachelor", abstract: 'This is an article test.'}

function IndexArticle(props) {
    return (
        <div className="elements">
            <h2 className="contents">
                <a href="#" onClick={ () => EachArticle(props)}>
                    {props.article.title}
                </a>
            </h2>
            <p className="contents">
                {props.article.abstract}
            </p>
        </div>
    );
}

function EachArticle(props) {
    return (
        <div>
            <h2 className="contents">
               {props.article.title}
            </h2>
            <div className="floating">
                <h4 className="content-start">
                    {props.article.author}
                </h4>
                <h4 className="content">
                    {props.article.year}
                </h4>
                <h4 className="content-end">
                    {props.article.degree}
                </h4>
            </div>
            <p className="abstract">{props.article.abstract}</p>
            <h4>
                <a href="download_path(@article.id)" className="contents">PDFダウンロード</a>
            </h4>
        </div>
    );
}

class Article extends React.Component {
    constructor() {
        super();
        this.state = {
            article: article
        };
    }
    render() {
        return (
            <div>
                <IndexArticle
                    article={article}
                />
            </div>
        );
    }
}

ReactDOM.render(
    <Article/>,
    document.getElementById('react_article'),
    // document.body.appendChild(document.createElement('div')),
);