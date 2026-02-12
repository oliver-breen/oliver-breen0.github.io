// Blog post data structure
const blogPosts = [
    {
        title: "Welcome to My Blog",
        date: "February 10, 2026",
        excerpt: "Welcome to my cybersecurity blog! Learn about what to expect, my background in transportation and aviation, and my journey into cybersecurity.",
        url: "blog/posts/welcome-to-my-blog.html"
    },
    {
        title: "Setting Up a Cybersecurity Home Lab",
        date: "February 8, 2026",
        excerpt: "A comprehensive guide to building your own cybersecurity home lab. Learn about hardware requirements, virtual machine setup, network configuration, and essential security tools.",
        url: "blog/posts/setting-up-home-lab.html"
    },
    {
        title: "TryHackMe Splunk Walkthrough",
        date: "February 5, 2026",
        excerpt: "Dive into Splunk with this detailed walkthrough of TryHackMe's Splunk rooms. Explore key commands, incident investigation techniques, and Boss of the SOC challenges.",
        url: "blog/posts/tryhackme-splunk-walkthrough.html"
    },
    {
        title: "Wireshark Packet Analysis Guide",
        date: "February 1, 2026",
        excerpt: "Master packet analysis with Wireshark. Learn about common protocols, filtering techniques, identifying suspicious traffic, and real-world analysis examples.",
        url: "blog/posts/wireshark-packet-analysis.html"
    },
    {
        title: "CompTIA Security+ Study Guide",
        date: "January 28, 2026",
        excerpt: "My comprehensive study guide for the CompTIA Security+ certification. Discover study resources, key domain overviews, practice tips, and exam strategies.",
        url: "blog/posts/comptia-security-plus-study-guide.html"
    }
];

// Function to display blog posts
function displayBlogPosts() {
    const container = document.getElementById('blog-posts-container');
    
    if (!container) {
        console.error('Blog posts container not found');
        return;
    }
    
    // Clear existing content
    container.innerHTML = '';
    
    // Create and append blog post cards
    blogPosts.forEach((post, index) => {
        const postCard = document.createElement('div');
        postCard.className = 'blog-post-card';
        postCard.style.animationDelay = `${index * 0.1}s`;
        
        postCard.innerHTML = `
            <div class="blog-post-date">${post.date}</div>
            <h2 class="blog-post-title">
                <a href="${post.url}">${post.title}</a>
            </h2>
            <p class="blog-post-excerpt">${post.excerpt}</p>
            <a href="${post.url}" class="read-more">Read More →</a>
        `;
        
        container.appendChild(postCard);
    });
}

// Initialize blog posts when DOM is loaded
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', displayBlogPosts);
} else {
    displayBlogPosts();
}
