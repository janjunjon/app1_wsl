import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from "prop-types"
// import {
//     BrowserRouter as Router,
//     Switch,
//     Route,
//     Link
// } from "react-router-dom";

const article = {id: 1, title: 'research0', author: 'jjthomson', year: 2020, degree: "bachelor", abstract: 'This is an article test.'}

// function IndexArticle(props) {
//     return (
//         <Router>
//             <div className="elements">
//                 <h2 className="contents">
//                     <Switch>
//                         <Route path="">
//                             {props.article.title}
//                         </Route>
//                     </Switch>
//                     <Link to={ {pathname: "/react_articles/" + props.article.id, state: {id: task.id}} }>
//                         {props.article.title}
//                     </Link>
//                     <a href="#" onClick={ () => EachArticle(props)}>
//                         {props.article.title}
//                     </a>
//                 </h2>
//                 <p className="contents">
//                     {props.article.abstract}
//                 </p>
//             </div>
//         </Router>
//     );
// }

function IndexArticles(props) {
    return (
        console.log(props.articles)
        // props.articles.map( article =>
        //     <div className="elements">
        //         <h2 className="contents">
        //             <a href="#" onClick={ () => EachArticle(props)}>
        //                 {article.title}
        //             </a>
        //         </h2>
        //         <p className="contents">
        //             {article.abstract}
        //         </p>
        //     </div>
        // )
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
    constructor(props) {
        super(props);
        this.state = {
            articles: this.props.articles
        };
    }
    render() {
        return (
            <div>
                <IndexArticles
                    articles={this.state.articles}
                />
            </div>
        );
    }
}

ReactDOM.render(
    <Article/>,
    document.getElementById('react_article'),
);