import React from "react"
import PropTypes from "prop-types"
class ReactArticle extends React.Component {
  render () {
    return (
      <React.Fragment>
        Greeting: {this.props.greeting}
      </React.Fragment>
    );
  }
}

ReactArticle.propTypes = {
  greeting: PropTypes.string
};
export default ReactArticle
